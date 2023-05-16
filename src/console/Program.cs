using System.Xml;

XmlDocument xmlDcoument = new XmlDocument();
xmlDcoument.LoadXml
xmlDcoument.Load(@"soap.xml");

 XmlElement root = xmlDcoument.DocumentElement;
XmlNodeList titleList = root.GetElementsByTagName("o:Username");

Console.WriteLine(titleList[0].InnerText);