import sys
import os
import time
from datetime import datetime
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
        print('The event is: ' + str(event) + '.')
        print('The time is: ' + str(datetime.now()) + '.')
        if event.src_path == FILE_PATH_TO_WATCH:
            print('The file of interest has been altered!  Executing git-bot...')
            try:
                output = subprocess.check_output('./git-bot.bash', shell=True)
                print(output)
            except Exception as e:
                print(e)

if __name__ == "__main__":
    print('Watching for alterations...')
    logging.basicConfig(level=logging.INFO,
                        format='%(asctime)s - %(message)s',
                        datefmt='%Y-%m-%d %H:%M:%S')
    event_handler = FileUpdateEventHandler()
    observer = Observer()
    observer.schedule(event_handler, DIR_PATH_TO_WATCH, recursive=True)
    observer.start()
    try:
        while True:
            time.sleep(2) # in seconds
    except KeyboardInterrupt:
        observer.stop()
    observer.join()
