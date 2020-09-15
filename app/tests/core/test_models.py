from django.test import TestCase
from django.contrib.auth import get_user_model


class ModelTests(TestCase):

    def test_create_user_with_email_successful(self):
        '''Test creating a new user with an email is successful.'''
        email = 'test@user.com'
        password = 'TestPass1234'
        user = get_user_model().objects.create_user(
            email=email, password=password
        )

        self.assertEqual(user.email, email)
        self.assertTrue(user.check_password(password))

    def test_new_user_email_normalized(self):
        '''Test the email for a new user is normalized'''
        email = 'test@UsER.Com'
        user = get_user_model().objects.create_user(
            email=email, password='pass12345'
        )

        self.assertEqual(user.email, email.lower())
