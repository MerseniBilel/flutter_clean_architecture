import 'package:clean_achitecture/features/post/domain/entites/post.dart';
import 'package:clean_achitecture/features/post/presentation/bloc/cud/add_delete_update_post_bloc.dart';
import 'package:clean_achitecture/features/post/presentation/widgets/custom_button.dart';
import 'package:clean_achitecture/features/post/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdate;
  final Post? post;
  const FormWidget({Key? key, required this.isUpdate, this.post})
      : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
  }

  void validThenUpdateOrAdd() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final updatedPost = Post(
          id: widget.isUpdate ? widget.post!.id : 0,
          title: _titleController.text,
          body: _bodyController.text);
      if (widget.isUpdate) {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(UpdatePostEvent(post: updatedPost));
      } else {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(AddPostEvent(post: updatedPost));
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomFormField(
            controller: _titleController,
            hint: 'Title',
            validator: (val) => val!.isEmpty ? "Title is required" : null,
          ),
          CustomFormField(
            controller: _bodyController,
            hint: 'Body',
            validator: (val) => val!.isEmpty ? 'Body is reqiured' : null,
            minLines: 6,
            maxLines: 6,
          ),
          CusomButton(
            onPressed: () => validThenUpdateOrAdd(),
            icon: widget.isUpdate
                ? const Icon(Icons.edit)
                : const Icon(Icons.add),
            label: Text(widget.isUpdate ? 'Update' : 'Add'),
          )
        ],
      ),
    );
  }
}
