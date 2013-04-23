package cricket;

import java.io.IOException;
import java.util.Date;
import java.util.logging.Logger;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

public class NewsServlet extends HttpServlet {
	private static final long serialVersionUID = 2800778962458456034L;
	private static final Logger log = Logger.getLogger(NewsServlet.class.getName());

	@Override
	public void doPost(final HttpServletRequest req, final HttpServletResponse resp) throws IOException {
		final UserService userService = UserServiceFactory.getUserService();
		final User user = userService.getCurrentUser();

		final Key newsKey = KeyFactory.createKey("News", "defaultNews");
		final String title = req.getParameter("title");
		final String content = req.getParameter("content");
		final Date date = new Date();

		final Entity news = new Entity("News", newsKey);
		news.setProperty("user", user);
		news.setProperty("date", date);
		news.setProperty("title", title);
		news.setProperty("content", content);

		final DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		datastore.put(news);
		final SendEmail email = new SendEmail();
		try {
			email.send(SendEmail.MAIL_TYPE.NEWS, title, content);
		} catch (final Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect("/profile/newsjq.jsp");
	}
}