import sys
import os
import time
import logging
import re
import subprocess

from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

# Load config vars
DIR_PATH_TO_WATCH=subprocess.check_output('source config.bash && printf "$NEWFILE_DIR_PATH"', shell=True).strip()
FILE_PATH_TO_WATCH=subprocess.check_output('source config.bash && printf "$NEWFILE_PATH"', shell=True).strip()


class FileUpdateEventHandler (FileSystemEventHandler):


    def on_created(self, event):
        print('A file or directory has been created.')
        return self.on_created_or_modified(event)

    def on_modified(self, event):
        print('A file or directory has been modified.')
        return self.on_created_or_modified(event)

    def on_created_or_modified(self, event):
        print('The event is: "' + str(event) + '".')
        print(event.src_path)
        print(type(event.src_path))
        if event.src_path == FILE_PATH_TO_WATCH:
            print('Found a new or modified file of interest.  Executing axel-bot...')
            try:
                print('about to subprocess.')
                output = subprocess.check_output('./axel-bot.sh', shell=True)
                print(output)
            except Exception as e:
                print(e)

if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO,
                        format='%(asctime)s - %(message)s',
                        datefmt='%Y-%m-%d %H:%M:%S')
    event_handler = FileUpdateEventHandler()
    observer = Observer()
    print('I start watch')
    observer.schedule(event_handler, DIR_PATH_TO_WATCH, recursive=True)
    observer.start()
    try:
        while True:
            time.sleep(0.5)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()
