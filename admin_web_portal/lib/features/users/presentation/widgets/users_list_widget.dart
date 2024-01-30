import 'package:admin_web_portal/common/extensions/build_context_extensions.dart';
import 'package:admin_web_portal/common/ui/widgets/table_data_widget.dart';
import 'package:admin_web_portal/features/users/presentation/cubit/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListWidget extends StatefulWidget {
  const UserListWidget({super.key});

  @override
  State<UserListWidget> createState() => _UserListWidgetState();
}

class _UserListWidgetState extends State<UserListWidget> {
  @override
  void initState() {
    context.read<UsersCubit>().getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersCubit, UsersState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is UsersFailed) {
          return Center(child: Text(state.error));
        }
        if (state is UsersSuccess) {
          final data = state.userList;
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
                    widget: Text(
                      data[index].name,
                      style: context.textTheme.titleSmall!,
                    ),
                  ),
                  TableDataWidget(
                    flexValue: 1,
                    widget: Text(
                      data[index].email,
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
