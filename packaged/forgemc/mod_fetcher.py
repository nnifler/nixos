import requests
import os

mod_path = "/var/lib/minecraft/mods"

def get_name(link: str):
  return link.split('/')[-1]

def get_mod(link: str):
  r = requests.get(link)
  name = get_name(link)
  with open(os.path.join(mod_path, name), "wb") as f:
    f.write(r.content)

def get_mod_list_file() -> str:
  return os.path.join(os.path.dirname(os.path.realpath(__file__)), "mod_links")


if __name__ == '__main__':
  with open(get_mod_list_file(), 'r') as f:
    links = list(map(lambda s : s.strip(), f.readlines()))

  present = os.listdir(mod_path)
  names_links = list(map(get_name, links))
  to_delete = list(filter(lambda m : m not in names_links, present))
  to_download = list(filter(lambda l : get_name(l) not in present, links))

  for d in to_delete:
    os.remove(os.path.join(mod_path, d))

  for l in to_download:
    get_mod(l)