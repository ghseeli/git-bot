import sys
import os
import time
import logging
import re
import subprocess

from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

# config
DIR = os.path.dirname(os.path.abspath(__file__))
PARENT_DIR = os.path.dirname(DIR)
UPSTREAM_REPO_NAME = "Integrable-Probability-Working-Seminar"
LOCAL_REPO_NAME = "axel-bot-{}".format(UPSTREAM_REPO_NAME)
LOCAL_REPO_PATH=os.path.join(PARENT_DIR, LOCAL_REPO_NAME)
print(LOCAL_REPO_PATH)

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
        if re.search(r'website\.md$', event.src_path):
            print('Found a new or modified file of interest.  Executing axel-bot...')
            try:
                print('about to subprocess.')
                print(subprocess.check_output('axel-bot.sh ' + str(event.src_path), shell=True))
            except Exception as e:
                print(e)

if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO,
                        format='%(asctime)s - %(message)s',
                        datefmt='%Y-%m-%d %H:%M:%S')
    event_handler = FileUpdateEventHandler()
    observer = Observer()
    print('I start watch')
    observer.schedule(event_handler, LOCAL_REPO_PATH, recursive=True)
    observer.start()
    try:
        while True:
            time.sleep(0.5)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()
