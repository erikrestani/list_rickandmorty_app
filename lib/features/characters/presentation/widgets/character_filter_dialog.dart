import 'package:flutter/material.dart';
import 'package:list_rickandmorty_app/core/theme/app_theme.dart';

class CharacterFilterDialog extends StatefulWidget {
  final Function(List<String>) onApplyFilters;
  final List<String> currentFilters;

  const CharacterFilterDialog({
    super.key,
    required this.onApplyFilters,
    required this.currentFilters,
  });

  @override
  State<CharacterFilterDialog> createState() => _CharacterFilterDialogState();
}

class _CharacterFilterDialogState extends State<CharacterFilterDialog> {
  late List<String> _selectedFilters;

  @override
  void initState() {
    super.initState();
    _selectedFilters = List.from(widget.currentFilters);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppTheme.surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.borderColorNeon, width: 2),
          boxShadow: [
            BoxShadow(
              color: AppTheme.neonShadowColor,
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.filter_list,
                    color: AppTheme.secondaryColor,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Filtrar Personagens',
                    style: AppTheme.titleStyle.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              _buildFilterOption(
                'Ordem Alfabética',
                'name',
                Icons.sort_by_alpha,
              ),
              const SizedBox(height: 16),
              
              _buildFilterOption(
                'Por Status',
                'status',
                Icons.favorite,
              ),
              const SizedBox(height: 24),
              
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Cancelar',
                        style: TextStyle(
                          color: AppTheme.textSecondaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onApplyFilters(_selectedFilters);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.secondaryColor,
                        foregroundColor: AppTheme.textColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Aplicar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterOption(String title, String filterKey, IconData icon) {
    final isSelected = _selectedFilters.contains(filterKey);
    
    return InkWell(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedFilters.remove(filterKey);
          } else {
            _selectedFilters.add(filterKey);
          }
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.cardBackgroundColor : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.borderColorNeon : AppTheme.borderColorLight,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppTheme.secondaryColor : AppTheme.textSecondaryColor,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected ? AppTheme.textColor : AppTheme.textSecondaryColor,
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.secondaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: isSelected ? AppTheme.secondaryColor : AppTheme.textSecondaryColor,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      color: AppTheme.textColor,
                      size: 14,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
