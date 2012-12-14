package logging;

import junit.framework.*;

import org.apache.activemq.broker.BrokerService;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.math.r.activemq.logger.Consumer;
import org.math.r.activemq.logger.Producer;

public class LoggerTest extends TestCase {
	Producer p = null;

	Consumer c = null;

	BrokerService broker = null;

	@Before
	public void setUp() {
		// broker = new BrokerService();
		// try {
		// broker.addConnector("tcp://localhost:61616");
		// broker.start();
		// } catch (Exception e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// }

		p = new Producer(null, "Q", "queue:junit:a");
		c = new Consumer(null, "Q", "queue:junit:a");
	}

	@Test
	public void testSendByteMessage() {
		Object result = p.send("This is a byte message".toString().getBytes(),
				"type", "byte-message");
		assertEquals(true, result);
	}

	@Test
	public void testRecieveByteMessage() {
		byte[] resultObj = (byte[]) c.consume("type", "byte-message");
		String result = new String(resultObj);

		assertEquals("This is a byte message", result);
	}

	@Test
	public void testSendTextMessage() {
		Object result = p
				.send("This is a text message", "type", "text-message");
		assertEquals(true, result);
	}

	@Test
	public void testRecieveTextMessage() {
		byte[] resultObj = (byte[]) c.consume("type", "text-message");
		String result=new String(resultObj);
		assertEquals("This is a text message", result);
	}

	@After
	public void tearDown() {
		p.destroy();
		c.destroy();
		// try {
		// broker.stop();
		// } catch (Exception e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// }
	}
}
