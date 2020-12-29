from django.contrib.auth.tokens import PasswordResetTokenGenerator


class ProfileActivationTokenGenerator(PasswordResetTokenGenerator):

    def _make_hash_value(self, user, timestamp):
        return user.pk + timestamp + user.profile.is_confirmed


profile_activation_token = ProfileActivationTokenGenerator()
