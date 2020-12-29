from django.shortcuts import render
from django.contrib.auth.forms import AuthenticationForm
from django.views.generic import FormView
from django.views import View

from .forms import RegistrationForm
from .tasks import check_user_verification


class RegistrationView(FormView):
    form_class = RegistrationForm
    template_name = "registration/registration.html"
    success_url = "/"

    def form_valid(self, form):
        form.save()
        return super().form_valid(form)


class ActivationView(View):

    def get(self, request, uidb64, token):

        context = {
            'form': AuthenticationForm(),
            'message': 'Registration confirmation error. '
                       'Please click the reset password to '
                       'generate a new confirmation email.'
        }

        if check_user_verification.delay(uidb64, token):
            context['message'] = 'Registration complete. Please login'

        return render(request, 'registration/login.html', context)