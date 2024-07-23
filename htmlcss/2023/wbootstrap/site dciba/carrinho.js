document.addEventListener('DOMContentLoaded', function () {
    const addToCartButtons = document.querySelectorAll('.add-to-cart');
    const cartItems = document.getElementById('cartItems');

    addToCartButtons.forEach(button => {
        button.addEventListener('click', function () {
            const product = this.getAttribute('data-product');
            const price = parseFloat(this.getAttribute('data-price'));
            
            const cartItem = document.createElement('div');
            cartItem.classList.add('cart-item');
            cartItem.innerHTML = `
                <div class="p-2">
                <p class="mx-2">${product} </p> <span class="">R$ ${price.toFixed(2)}</span>
                <div>
            `;
            cartItems.appendChild(cartItem);
        });
    });
});
