import os
import hvac

class VaultLoader:
    def __init__(self):
        self.app_env = os.environ.get('APP_ENV') or 'dev'
        self.timeout = 2
        self.addr = os.environ.get('VAULT_ADDR')
        self.client = hvac.Client(url=self.addr, token=os.environ['VAULT_TOKEN'])

    def is_sealed(self):
        return self.client.is_sealed()

    def unseal(self, key):
        self.client.unseal(key)

    def seal(self):
        self.client.seal()

    def read(self, key):
        secret = self.client.read(key)
        if secret:
            return secret
        else:
            raise StandardError("Invalid path to secret!")

    def delete(self, key):
        self.client.delete(key)