import os

def save_directory_tree(start_path, output_file, indent=''):
    items = [item for item in os.listdir(start_path) if not item.startswith('.')]  # Exclude hidden items
    for index, item in enumerate(items):
        path = os.path.join(start_path, item)
        is_last = index == len(items) - 1
        prefix = '└── ' if is_last else '├── '
        
        output_file.write(indent + prefix + item + '\n')
        
        if os.path.isdir(path):
            new_indent = indent + ('    ' if is_last else '│   ')
            save_directory_tree(path, output_file, new_indent)

if __name__ == "__main__":
    current_directory = os.getcwd()  # Gets the current directory
    output_file_path = os.path.join(current_directory, "directory_hierarchy.txt")
    
    with open(output_file_path, "w") as output_file:
        output_file.write(current_directory + '\n')  # Write the root directory
        save_directory_tree(current_directory, output_file)
    
    print(f"Directory hierarchy saved to {output_file_path}")