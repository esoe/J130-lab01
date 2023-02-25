package ru.molokoin;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
 
/**
 * тест загрузчика sql скриптов
 * !!! не работает !!!
 */
public class DBScriptRunner {
 
   public static void main(String[] args) {
	try {
		executeScriptUsingStatement();
	} catch (IOException e) {
		e.printStackTrace();
	} catch (SQLException e) {
		e.printStackTrace();
	}
   }
 
   static void executeScriptUsingStatement() throws IOException, SQLException {
	String scriptFilePath = "src\\sql\\All-in-one.sql";
	BufferedReader reader = null;
	Connection con = null;
	Statement statement = null;
	try {
		// load driver class for mysql
		Class.forName("com.mysql.jdbc.Driver");
		// create connection
		con = DriverManager.getConnection("jdbc:mysql://molokoin.ru:3306", 
                             "qqqq", "qqqq");
		// create statement object
		statement = con.createStatement();
		// initialize file reader
		reader = new BufferedReader(new FileReader(scriptFilePath));
		String line = null;
		int i = 0;// счетчик обработанных строк
		// read script line by line
		while ((line = reader.readLine()) != null) {
			System.out.println("Обработка строки: " + i + " ...");
			// execute query
			statement.execute(line);
			System.out.println("успешно звыершена!");
			i++;
		}
		System.out.println("Запрос полностью обработан!");
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		// close file reader
		if (reader != null) {
			reader.close();
		}
		// close db connection
		if (con != null) {
			con.close();
		}
	}
   }
}
