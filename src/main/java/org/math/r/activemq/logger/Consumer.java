package org.math.r.activemq.logger;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.MessageConsumer;
import javax.jms.Session;

import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;
import org.apache.activemq.command.ActiveMQBytesMessage;
import org.apache.activemq.command.ActiveMQMessage;
import org.apache.activemq.command.ActiveMQTextMessage;

public class Consumer {
	private String url = ActiveMQConnection.DEFAULT_BROKER_URL;

	private Session session;

	private MessageConsumer consumer;

	private Connection connection;

	public Consumer(String url, String field, String name) {
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
			consumer = session.createConsumer(destination);
		} catch (JMSException e) {
			e.printStackTrace();
		}
	}

	public byte[] consume(String propertyName, String propertyValue) {
		byte[] obj = null;
		try {
			ActiveMQMessage message = (ActiveMQMessage) consumer.receive();
			if (message instanceof ActiveMQBytesMessage)
				obj = message.getContent().getData();
			else if (message instanceof ActiveMQTextMessage)
				obj = ((ActiveMQTextMessage) message).getText().toString()
						.getBytes();

			if (propertyName != null && propertyValue != null) {
				{
					String expectedPropertyValue = message
							.getStringProperty(propertyName);
					if (!propertyValue.equals(expectedPropertyValue)) 
						obj = null;
				}

			}
		} catch (JMSException e) {
			e.printStackTrace();
		}
		return obj;
	}

	public boolean destroy() {
		Boolean success = false;
		try {
			connection.close();
			success = true;
		} catch (JMSException e) {
			e.printStackTrace();
			success = false;
		}
		return success;
	}
}
