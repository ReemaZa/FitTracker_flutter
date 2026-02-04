import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/primary_botton.dart';
import '../../../../core/utils/goal_metrics.dart';
import '../../domain/entities/goal.dart';
import '../../domain/usecases/create_goal_params.dart';
import '../providers/goals_provider.dart';
import '../widgets/goal_type_selector.dart';
import '../widgets/frequency_selector.dart';
import '../widgets/week_days_selector.dart';
import '../widgets/times_per_week_selector.dart';

class AddGoalPage extends StatefulWidget {
  const AddGoalPage({super.key});

  @override
  State<AddGoalPage> createState() => _AddGoalPageState();
}

class _AddGoalPageState extends State<AddGoalPage> {
  final _titleController = TextEditingController();
  final _targetController = TextEditingController();

  GoalTypeUI _goalType = GoalTypeUI.walking;
  GoalFrequency _frequency = GoalFrequency.daily;

  GoalMetricType _metricType = GoalMetricType.duration;
  String _unit = 'minutes';

  List<int> _selectedDays = [];
  int _timesPerWeek = 3;

  void _onMetricTypeChanged(GoalMetricType type) {
    setState(() {
      _metricType = type;
      _unit = GoalMetricConfig.units[type]!.first;

      if (type == GoalMetricType.binary) {
        _targetController.text = '1';
      } else {
        _targetController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final availableUnits = GoalMetricConfig.units[_metricType]!;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Add Goal'),
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle(context, 'Goal Type'),
                  GoalTypeSelector(
                    selected: _goalType,
                    onChanged: (type) => setState(() => _goalType = type),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle(context, 'Goal Details'),
                  _input('Title', _titleController),
                  const SizedBox(height: 12),

                  /// Metric Type
                  DropdownButtonFormField<GoalMetricType>(
                    value: _metricType,
                    decoration: const InputDecoration(labelText: 'Metric Type'),
                    items: GoalMetricType.values.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(GoalMetricConfig.label(type)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) _onMetricTypeChanged(value);
                    },
                  ),

                  const SizedBox(height: 12),

                  /// Unit
                  DropdownButtonFormField<String>(
                    value: _unit,
                    decoration: const InputDecoration(labelText: 'Unit'),
                    items: availableUnits
                        .map(
                          (unit) => DropdownMenuItem(
                        value: unit,
                        child: Text(unit),
                      ),
                    )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _unit = value);
                      }
                    },
                  ),

                  const SizedBox(height: 12),

                  /// Target (hidden for binary)
                  if (_metricType != GoalMetricType.binary)
                    _input(
                      'Target',
                      _targetController,
                      keyboardType: TextInputType.number,
                    ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle(context, 'Schedule'),
                  FrequencySelector(
                    selected: _frequency,
                    onChanged: (value) => setState(() => _frequency = value),
                  ),
                  if (_frequency == GoalFrequency.weekly) ...[
                    const SizedBox(height: 16),
                    WeekDaysSelector(
                      selectedDays: _selectedDays,
                      onChanged: (days) =>
                          setState(() => _selectedDays = days),
                    ),

                  ],
                ],
              ),
            ),

            const SizedBox(height: 32),

            PrimaryButton(
              label: 'Create Goal',
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }

  void _submit() async {
    final provider = context.read<GoalsProvider>();

    final params = CreateGoalParams(
      title: _titleController.text,
      description: '',
      goalType: _goalType.name,
      metricType: _metricType.name,
      targetValue: num.parse(_targetController.text),
      unit: _unit,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 365)),
      frequencyType: _frequency.name,
      daysOfWeek: _frequency == GoalFrequency.weekly
          ? _selectedDays
          : [],
    );

    try {
      await provider.addGoal(params);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to create goal')),
      );
    }
  }


  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.grayMedium.withOpacity(0.25),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _input(
      String label,
      TextEditingController controller, {
        TextInputType keyboardType = TextInputType.text,
      }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
