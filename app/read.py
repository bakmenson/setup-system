def read_data(file_name: str) -> list[str]:
    file_data: list[str] = []

    try:
        with open(file_name, "r") as data:
            file_data = data.readlines()
    except FileNotFoundError:
        print(f"No such file: {file_name}")
    except OSError:
        print(f"File name: '{file_name}' most be string. Please change file name.")
    finally:
        if not file_data:
            exit()

    return file_data
