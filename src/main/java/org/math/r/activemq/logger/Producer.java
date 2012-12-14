package org.math.r.activemq.logger;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.MessageProducer;
import javax.jms.Session;

import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;
import org.apache.activemq.command.ActiveMQBytesMessage;
import org.apache.activemq.command.ActiveMQTextMessage;

public class Producer {
	private String url = ActiveMQConnection.DEFAULT_BROKER_URL;

	private Session session;

	private MessageProducer producer;

	private Connection connection;

	public Producer(String url, String field, String name) {
		if (url != null)
			this.url = url;
		ConnectionFactory connectionFactory = new ActiveMQConnectionFactory(
				this.url);

		try {
			connection = connectionFactory.createConnection();
			connection.start();

			session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
			Destination destination;
			if ("T".equals(field))
				destination = session.createTopic(name);
			else
				destination = session.createQueue(name);
			producer = session.createProducer(destination);
		} catch (JMSException e) {
			e.printStackTrace();
		}
	}

	public boolean send(byte[] obj, String propertyName, String propertyValue) {
		Boolean success = false;
		try {
			ActiveMQBytesMessage message = new ActiveMQBytesMessage();
			message.writeBytes(obj);
			if (propertyName != null)
				message.setStringProperty(propertyName, propertyValue);
			producer.send(message);

			success = true;
		} catch (JMSException e) {
			success = false;
			e.printStackTrace();
		}
		return success;

	}

	public boolean send(String obj, String propertyName, String propertyValue) {
		Boolean success = false;
		try {
			ActiveMQTextMessage message = new ActiveMQTextMessage();
			message.setText(obj);
			if (propertyName != null)
				message.setStringProperty(propertyName, propertyValue);
			producer.send(message);

			success = true;
		} catch (JMSException e) {
			success = false;
			e.printStackTrace();
		}
		return success;

	}

	public boolean destroy() {
		Boolean success = false;
		try {
			connection.close();
			success = true;
		} catch (JMSException e) {
			success = false;
			e.printStackTrace();
		}
		return success;
	}

}