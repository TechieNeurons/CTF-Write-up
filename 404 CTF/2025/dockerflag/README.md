# Dockerflag

#easy #docker 

> En vous baladant sur le système informatique du vaisseau, vous tombez sur un vieux projet réalisé il y a bien longtemps, dans une galaxie lointaine, très lointaine. Le projet avait été arrêté assez rapidement et supprimé de votre Gitlab interne, mais peut-être que l'image Docker du site web que vous avez en votre possession a encore quelques secrets bien gardés...

## Analysis
We have a tar fil, after extraction we have one tar file for each docker layer a manifest file and a sha256 file

Check the manifest: `cat manifest.json | jq .`

We learn that the sha file is the config of the dockerwe also get the repo and each layers.

The config file give us some info like commands launch on the docker:
```
WORKDIR /app
COPY git_repos/ .
```

So we have an app and some git, I used this script to extracrt all layers:
```
for layer in *.tar.gz; do
    mkdir -p "layer_analysis/${layer%.tar.gz}"
    tar -xzvf "$layer" -C "layer_analysis/${layer%.tar.gz}"
done
```

Then I go in the folder (`cd layer_analysis`) and did a `tree -da` (to find in which layer are the *app* and *.git* all these layers contains the app folder:
```
5e76ef2b84193ccb29c672d49c9f9134aaac6c2f9af4f26b44584d5190f3dc41
c0f44320de6915ebd75512f6564344e5aac1b91cb82573690a8061f561804aad
c3e571d9ad58726bad8935e6692b4f21152237c4fdd0a1c913101361cc091fb7
```

From bottom to top:
```
┌──(kali㉿kali)-[~/…/dockerflag/layer_analysis/c3e571d9ad58726bad8935e6692b4f21152237c4fdd0a1c913101361cc091fb7/app]
└─$ ls -la
total 8
drwxr-xr-x 2 kali kali 4096 Mar  3 12:17 .
drwxr-xr-x 3 kali kali 4096 Mar  3 12:17 ..
---------- 1 kali kali    0 Dec 31  1969 .wh..git
```

This file seems broken. Nothin to see here, in the c0f44320de6915ebd75512f6564344e5aac1b91cb82573690a8061f561804aad layer we have the .git and this app.py:
```
import os

from flask import Flask, render_template
from dotenv import load_dotenv

load_dotenv()
SECRET_KEY = os.getenv("SECRET", default="WHERE IS ZE DOTENV ?")

app = Flask(__name__)

@app.route('/')
def index():
    return render_template("index.html")

app.run(debug=False, host="0.0.0.0", port=5000) 
```

Maybe find the dotenv ?

Lets dive in the .git, I did a `git init` then `git branch`, only one branch "main" and here is the logs:
```
git log main --stat
commit e3a5491ad536b35974022c3b521d3b48880afb68 (main)
Author: Alba Laine <stagiare@docker.flag>
Date:   Mon Mar 3 17:17:28 2025 +0000

    Add HTML website

 templates/index.html | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

commit b34c648f6790f6dee4340767ddf4b077f639132d
Author: Alba Laine <stagiare@docker.flag>
Date:   Mon Mar 3 17:17:28 2025 +0000

    Requirements of website

 requirements.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

commit 514443de0db750428f03d41d2be47e8c6d066981
Author: Alba Laine <stagiare@docker.flag>
Date:   Mon Mar 3 17:17:28 2025 +0000

    Add static ressources

 .env             |   1 -
 static/logo.png  | Bin 0 -> 7460 bytes
 static/style.css |   0
 3 files changed, 1 deletion(-)

commit 3d0717cb911d00b3e5033ba8c0c83df069e3e144
Author: Alba Laine <stagiare@docker.flag>
Date:   Mon Mar 3 17:17:28 2025 +0000

    Last commit before week-end !

 .env | 1 +
 1 file changed, 1 insertion(+)

commit c8e66485c89a29768dd546a3046b8544520615d6
Author: Alba Laine <stagiare@docker.flag>
Date:   Mon Mar 3 17:17:28 2025 +0000

    Source code of website

 app.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
```

We can see a .env file added in the second commit and deleted in the third commit... Let's print that:
```
git show 3d0717cb911d00b3e5033ba8c0c83df069e3e144
commit 3d0717cb911d00b3e5033ba8c0c83df069e3e144
Author: Alba Laine <stagiare@docker.flag>
Date:   Mon Mar 3 17:17:28 2025 +0000

    Last commit before week-end !

diff --git a/.env b/.env
new file mode 100644
index 0000000..350f10b
--- /dev/null
+++ b/.env
@@ -0,0 +1 @@
+SECRET="404CTF{492f3f38d6b5d3ca859514e250e25ba65935bcdd9f4f40c124b773fe536fee7d}"
```

here is the flag !