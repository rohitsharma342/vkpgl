import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../utils/theme.dart';
import '../utils/constants.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;
  
  const CartItemWidget({
    super.key,
    required this.cartItem,
    required this.onQuantityChanged,
    required this.onRemove,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildProductImage(),
          const SizedBox(width: 12),
          Expanded(
            child: _buildProductInfo(context),
          ),
          _buildQuantityControls(),
        ],
      ),
    );
  }
  
  Widget _buildProductImage() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          cartItem.product.images.first,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              color: Colors.grey[200],
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[200],
              child: const Icon(
                Icons.image_not_supported,
                color: AppTheme.textSecondary,
              ),
            );
          },
        ),
      ),
    );
  }
  
  Widget _buildProductInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          cartItem.product.brand,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          cartItem.product.name,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          '${AppConstants.currency}${cartItem.product.price.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onRemove,
          child: Row(
            children: [
              Icon(
                Icons.delete_outline,
                size: 16,
                color: AppTheme.errorColor,
              ),
              const SizedBox(width: 4),
              Text(
                'Remove',
                style: TextStyle(
                  color: AppTheme.errorColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildQuantityControls() {
    return Column(
      children: [
        Text(
          '${AppConstants.currency}${cartItem.totalPrice.toStringAsFixed(2)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildQuantityButton(
                Icons.remove,
                () {
                  if (cartItem.quantity > 1) {
                    onQuantityChanged(cartItem.quantity - 1);
                  }
                },
                cartItem.quantity <= 1,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  cartItem.quantity.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              _buildQuantityButton(
                Icons.add,
                () {
                  onQuantityChanged(cartItem.quantity + 1);
                },
                false,
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildQuantityButton(
    IconData icon,
    VoidCallback onPressed,
    bool isDisabled,
  ) {
    return InkWell(
      onTap: isDisabled ? null : onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Icon(
          icon,
          size: 16,
          color: isDisabled ? Colors.grey[400] : AppTheme.textPrimary,
        ),
      ),
    );
  }
}