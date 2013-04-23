package cricket;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

public class SendEmail {

	public enum MAIL_TYPE {
		NEWS
	}

	public void send(final MAIL_TYPE mailType, final String subject, final String contents) throws Exception {
		final Properties props = new Properties();
		final Session session = Session.getDefaultInstance(props, null);

		//final String category = mailType.equals(MAIL_TYPE.NEWS) ? "News" : "Activity";
		//final String msgBody = "New " + category + ", please check the website! (" + subject + ")";

		try {
			final UserService userService = UserServiceFactory.getUserService();
			final User user = userService.getCurrentUser();

			final Message msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(user.getEmail(), "Dare Devils"));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(user.getEmail(), ""));
			//msg.setSubject("New " + category + " at Dare Devils!");
			msg.setSubject(subject);
			//msg.setText(msgBody);
			msg.setText(contents);
			msg.setDescription(contents);
			Transport.send(msg);

		} catch (final AddressException e) {
			// ...
		} catch (final MessagingException e) {
			// ...
		}
	}

}
