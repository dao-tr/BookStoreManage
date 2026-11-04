function addToCart(id, name, price) {
    fetch('/api/cart', {
        method: 'POST',
        body: JSON.stringify({
            "id": id,
            "name": name,
            "price": price
        }),
        headers: {
            'Content-Type': 'application/json'
        }
    }).then(res => res.json()).then(data => {
        let counters = document.getElementsByClassName('cart-counter');
        for (let c of counters)
            c.innerText = data.total_quantity;
    });
}

function updateCart(bookId, obj) {
    fetch(`/api/cart/${bookId}`, {
        method: 'PUT',
        body: JSON.stringify({
            "quantity": obj.value
        }),
        headers: {
            'Content-Type': 'application/json'
        }
    }).then(res => res.json()).then(data => {
        let counters = document.getElementsByClassName('cart-counter');
        for (let c of counters)
            c.innerText = data.total_quantity;
        let amounts = document.getElementsByClassName('cart-amount');
        for (let a of amounts)
            a.innerText = new Intl.NumberFormat().format(data.total_amount);
    });
}

function deleteCart(bookId) {
    if (confirm("Bạn chắc chắn muốn xóa sách khỏi giỏ hàng?") === true) {
        fetch(`/api/cart/${bookId}`, {
            method: 'DELETE'
        }).then(res => res.json()).then(data => {
            let counters = document.getElementsByClassName('cart-counter');
            for (let c of counters)
                c.innerText = data.total_quantity;
            let amounts = document.getElementsByClassName('cart-amount');
            for (let a of amounts)
                a.innerText = new Intl.NumberFormat().format(data.total_amount);
            let el = document.getElementById(`book${bookId}`);
            if (el) el.style.display = "none";
        });
    }
}

function pay() {
    let paymentMethod = document.querySelector('input[name="payment_method"]:checked').value;
    let deliveryAddress = document.getElementById('delivery_address').value;

    if (paymentMethod === 'ONLINE_FREE_SHIP' && !deliveryAddress.trim()) {
        alert("Chưa lòng nhập địa chỉ giao hàng!");
        return;
    }

    if (confirm("Xác nhận?") === true) {
        fetch('/api/pay', {
            method: 'POST',
            body: JSON.stringify({
                "payment_method": paymentMethod,
                "delivery_address": deliveryAddress
            }),
            headers: {
                'Content-Type': 'application/json'
            }
        }).then(res => res.json()).then(data => {
            if (data.status === 200) {
                alert(data.msg);
                location.reload();
            } else {
                alert(data.err_msg);
            }
        });
    }
}