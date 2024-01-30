import 'package:admin_web_portal/common/extensions/build_context_extensions.dart';
import 'package:admin_web_portal/common/ui/widgets/table_data_widget.dart';
import 'package:admin_web_portal/features/drivers/presentation/cubit/drivers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DriverListWidget extends StatefulWidget {
  const DriverListWidget({super.key});

  @override
  State<DriverListWidget> createState() => _DriverListWidgetState();
}

class _DriverListWidgetState extends State<DriverListWidget> {
  @override
  void initState() {
    context.read<DriversCubit>().getDrivers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriversCubit, DriversState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is DriversFailed) {
          return Center(child: Text(state.error));
        }
        if (state is DriversSuccess) {
          final data = state.driverList;
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (ctx, index) {
              return Row(
                children: [
                  TableDataWidget(
                    flexValue: 2,
                    widget: Text(
                      data[index].id,
                      style: context.textTheme.titleSmall,
                    ),
                  ),
                  TableDataWidget(
                    flexValue: 1,
                    widget: Image.network(
                      data[index].photo,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  TableDataWidget(
                    flexValue: 1,
                    widget: Text(
                      data[index].name,
                      style: context.textTheme.titleSmall!,
                    ),
                  ),
                  TableDataWidget(
                    flexValue: 1,
                    widget: Text(
                      "${data[index].carDetails.carModel} ${data[index].carDetails.carNumber}",
                      style: context.textTheme.titleSmall!,
                    ),
                  ),
                  TableDataWidget(
                    flexValue: 1,
                    widget: Text(
                      data[index].phone,
                      style: context.textTheme.titleSmall!,
                    ),
                  ),
                  TableDataWidget(
                    flexValue: 1,
                    widget: Text(
                      "\$ 0",
                      style: context.textTheme.titleSmall!,
                    ),
                  ),
                  TableDataWidget(
                    flexValue: 1,
                    widget: data[index].blockStatus
                        ? SizedBox(
                            width: 50,
                            height: 25,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Block",
                                style: context.textTheme.titleSmall!.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : SizedBox(
                            width: 50,
                            height: 25,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(0)),
                              child: Text(
                                "Unblock",
                                style: context.textTheme.titleSmall!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                  ),
                ],
              );
            },
            itemCount: data.length,
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
