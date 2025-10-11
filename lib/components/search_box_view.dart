import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SerchBoxView extends HookWidget {
  const SerchBoxView({super.key, this.onSearch});

  final void Function(String)? onSearch;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final text = useState(controller.text);

    useEffect(() {
      void listener() => text.value = controller.text;
      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller],);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: 56,
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 4, right: 4),
                child: Icon(Icons.search, color: Colors.grey),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  textInputAction: TextInputAction.search,
                  decoration: const InputDecoration(
                    hintText: 'Search repositories',
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  onSubmitted: (value) {
                    onSearch?.call(value);
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              if (text.value.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.clear();
                    onSearch?.call('');
                    FocusScope.of(context).unfocus();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
