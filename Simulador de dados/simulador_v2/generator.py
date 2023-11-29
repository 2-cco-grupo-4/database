from faker import Faker
from sqlalchemy import create_engine, Column, Integer, String, Text, DateTime, Date, Float, ForeignKey, Index
from sqlalchemy.orm import declarative_base, sessionmaker
from sqlalchemy.sql import func
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.exc import IntegrityError, DataError
import random
from datetime import datetime
from art import *

# Configuração do banco de dados
DATABASE_URL = "mysql://root:picmedb1234@3.221.59.77/picme"
engine = create_engine(DATABASE_URL, pool_size=25, max_overflow=5)

# Definindo a estrutura das tabelas
Base = declarative_base()

listTemas = [
    "Casamento",
    "Vintage",
    "Evento",
    "Familia",
    "Aniversario",
    "Festa",
    "Animais",
    "Debutante",
    "Formatura",
    "Esporte",
    "Paisagem",
    "Natureza",
    "Moda",
    "Viagem",
    "Gastronomia",
]

listTags = [
    "Urbano",
    "Preto e Branco",
    "Ar Livre",
    "Praia",
    "Pets",
    "Cachorro",
    "Gato",
    "Familia",
    "Evento",
    "Multidao",
    "Filtro",
    "Sorriso",
    "Noite",
    "Entardecer",
    "Tarde",
    "Manha",
    "Chuva",
    "Paisagem",
    "Rio de Janeiro",
    "Cristo",
    "Parque",
    "Cultura",
]

urls_natureza = [
    "https://plus.unsplash.com/premium_photo-1683290222216-a9fab340cbf8?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Q2FzYW1lbnRvfGVufDB8fDB8fHww&w=500",
    "https://images.unsplash.com/photo-1623787391876-0dbc0f258476?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1586804199509-4b1ecaca6fa3?q=80&w=1370&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1528892677828-8862216f3665?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1525811902-f2342640856e?q=80&w=1471&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1673965391434-71dd7ea34c2b?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1414609245224-afa02bfb3fda?q=80&w=1378&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1650322178502-649e8f9c67c5?q=80&w=1472&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1627798012829-658f8a4b426d?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
]

urls_casamento = [
    "https://images.unsplash.com/photo-1649183424680-464747a8e43d?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Q2FzYW1lbnRvfGVufDB8fDB8fHww&w=500",
    "https://images.unsplash.com/photo-1532712938310-34cb3982ef74?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Q2FzYW1lbnRvfGVufDB8fDB8fHww&w=500",
    "https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8Q2FzYW1lbnRvfGVufDB8fDB8fHww&w=500",
    "https://images.unsplash.com/photo-1583939003579-730e3918a45a?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8Q2FzYW1lbnRvfGVufDB8fDB8fHww&w=500",
    "https://images.unsplash.com/photo-1546032996-6dfacbacbf3f?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fENhc2FtZW50b3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1523438885200-e635ba2c371e?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fENhc2FtZW50b3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1607190074257-dd4b7af0309f?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjF8fENhc2FtZW50b3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1595732301236-42a26208b2fc?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDF8fEZlc3RhJTIwZGUlMjBBbml2ZXJzYXJpb3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1608245536505-9bab008d00d3?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",

]

urls_festa = [
    "https://images.unsplash.com/photo-1541532713592-79a0317b6b77?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fEZlc3Rhc3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1533219057257-4bb9ed5d2cc6?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NjR8fEZlc3Rhc3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1517457373958-b7bdd4587205?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NzV8fEZlc3RhJTIwZGUlMjBBbml2ZXJzYXJpb3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1701095767356-0927702c51b8?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1527529482837-4698179dc6ce?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1528495612343-9ca9f4a4de28?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1501238295340-c810d3c156d2?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1586105449897-20b5efeb3233?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1539758462369-43adaa19bc1f?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1496337589254-7e19d01cec44?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
]

urls_aniversario = [
    "https://images.unsplash.com/photo-1544155891-969f15a055d3?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjR8fEZlc3Rhc3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1544155892-b2b6c64204fc?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fEZlc3RhJTIwZGUlMjBBbml2ZXJzYXJpb3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1533294160622-d5fece3e080d?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NTJ8fEZlc3RhJTIwZGUlMjBBbml2ZXJzYXJpb3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1602631985686-1bb0e6a8696e?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1608790672275-309c02d888ff?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1615445565741-c60a9edd393f?q=80&w=1406&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1509666537727-9154b6962292?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1482731910308-31e96e5d1d28?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
]

urls_gastronomia = [
    "https://images.unsplash.com/photo-1621857426350-ddab819cf0cc?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDd8fEZlc3RhJTIwZGUlMjBBbml2ZXJzYXJpb3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1499715217757-2aa48ed7e593?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1571989569011-ff63072f08b0?q=80&w=1476&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1607688719755-7a7d78d26ca9?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1488992783499-418eb1f62d08?q=80&w=1589&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1579178404481-14046f8e13e7?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
]

urls_debutante = [
    "https://images.unsplash.com/photo-1503315082045-a2bfb5e7f56e?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NTl8fEZlc3RhJTIwZGUlMjBBbml2ZXJzYXJpb3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1603862018057-8a1ae272751a?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nzd8fEZlc3RhJTIwZGUlMjBBbml2ZXJzYXJpb3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1598028445822-98171b8bcec1?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OTR8fEZlc3RhJTIwZGUlMjBBbml2ZXJzYXJpb3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1517263904808-5dc91e3e7044?q=80&w=1376&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1525373612132-b3e820b87cea?q=80&w=1480&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1503218751919-1ea90572e609?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
]

urls_viagem = [
    "https://images.unsplash.com/photo-1650725965407-15030ba9fccf?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1527631746610-bca00a040d60?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1527631615371-98cbbff5125a?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1548637266-ce260667a350?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1613400843540-9ec3e35ef5f8?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1701077136756-3b8439292118?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500"

]

urls_esporte = [
    "https://images.unsplash.com/photo-1687899951711-a7571b7b3833?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1608245449230-4ac19066d2d0?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1549896869-ca27eeffe4fb?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1541252260730-0412e8e2108e?q=80&w=1574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1565992441121-4367c2967103?q=80&w=1527&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1547941126-3d5322b218b0?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://plus.unsplash.com/premium_photo-1671436823453-68df752b3d36?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1553108715-308e8537ce55?q=80&w=1528&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1622599511051-16f55a1234d0?q=80&w=1472&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1551698618-1dfe5d97d256?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
]

urls_moda = [
    "https://images.unsplash.com/photo-1585056965778-3e7b17a3340c?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1525299374597-911581e1bdef?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1529139574466-a303027c1d8b?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1566206091558-7f218b696731?q=80&w=1528&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1608748010899-18f300247112?q=80&w=1528&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1578632292335-df3abbb0d586?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1588117305388-c2631a279f82?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500"
]

urls_vintage = [
    "https://images.unsplash.com/photo-1698924923395-fa5707a074e5?q=80&w=1471&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1501829385782-9841539fa6bf?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1522775417749-29284fb89f43?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1479791261936-65db171c3cc5?q=80&w=1476&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1488841714725-bb4c32d1ac94?q=80&w=1430&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1544129564-b07b639606bb?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1488693161025-5f967b74de89?q=80&w=1459&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1476081718509-d5d0b661a376?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
]

urls_animais = [
    "https://images.unsplash.com/photo-1524173524-921aa42365ca?q=80&w=1528&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1592754862816-1a21a4ea2281?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1623387641168-d9803ddd3f35?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1504595403659-9088ce801e29?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1601758177266-bc599de87707?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1563460716037-460a3ad24ba9?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1604848698030-c434ba08ece1?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1517849845537-4d257902454a?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1560807707-8cc77767d783?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1629740067905-bd3f515aa739?q=80&w=1376&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500"
]

urls_paisagem = [
    "https://images.unsplash.com/photo-1506744038136-46273834b3fb?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1532274402911-5a369e4c4bb5?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1511884642898-4c92249e20b6?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1494500764479-0c8f2919a3d8?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1470770841072-f978cf4d019e?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1501785888041-af3ef285b470?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
]

urls_evento = [
    "https://images.unsplash.com/photo-1540575467063-178a50c2df87?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1517048676732-d65bc937f952?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1505373877841-8d25f7d46678?q=80&w=1412&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1511578314322-379afb476865?q=80&w=1469&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1475721027785-f74eccf877e2?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1561489396-888724a1543d?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1556761175-5973dc0f32e7?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
]

urls_familia = [
    "https://images.unsplash.com/photo-1609220136736-443140cffec6?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1655185497013-db98aca061d3?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1657664058220-a1bfc04e2e14?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1643818657367-491080baeece?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1643868420405-48e32c6f4620?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1647833202056-e6e67293ba81?q=80&w=1412&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1643869355390-4dcffc63d049?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1561525140-c2a4cc68e4bd?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1559734840-f9509ee5677f?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1611024847487-e26177381a3f?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
]

urls_formatura = [
    "https://images.unsplash.com/photo-1523050854058-8df90110c9f1?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1627556704302-624286467c65?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1623461487986-9400110de28e?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1565034946487-077786996e27?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1523580846011-d3a5bc25702b?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1590012314607-cda9d9b699ae?q=80&w=1471&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1625061770820-514e6228f4ee?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1619279302118-43033660826a?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1628887919785-ae536631cb76?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1639765766830-d829d2fe4219?q=80&w=1446&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1627556704290-2b1f5853ff78?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
]

listFormaPagamento = [
    "Pix",
    "Cartão de Crédito",
    "Transferência Bancária",
    "Boleto Bancário"
]

temas_e_urls = {
    1: urls_casamento,
    2: urls_vintage,
    3: urls_evento,
    4: urls_familia,
    5: urls_aniversario,
    6: urls_festa,
    7: urls_animais,
    8: urls_debutante,
    9: urls_formatura,
    10: urls_esporte,
    11: urls_paisagem,
    12: urls_natureza,
    13: urls_moda,
    14: urls_viagem,
    15: urls_gastronomia,
}

status_sessoes = [
    "Proposta",
    "Em negociação",
    "Agendada",
    "Realizada",
    "Cancelada",
]

possiveis_titulos = {
    1 : ["Amor Eterno em Fotografias",
                    "Instantes Matrimoniais",
                    "A Jornada do Sim",
                    "Romance Capturado",
                    "Votos em Imagens",
                    "Cumplicidade Fotográfica",
                    "Casamento dos Sonhos",
                    "Eternizando Promessas",
                    "Momentos Mágicos",
                    "Conexão Nupcial"],
    2 : ["Era Retrô Revelada",
                    "Estilo Clássico em Imagens",
                    "Vintage: Passado Presente",
                    "Retrospetiva Fotográfica",
                    "Elegância Antiga",
                    "Cenas Nostálgicas",
                    "Tesouros do Passado",
                    "Vintage Charmoso",
                    "Retratos do Tempo",
                    "Colecionando Memórias Vintage"],
    3 : ["Registro de Eventos Especiais",
                    "Detalhes que Marcam",
                    "Cobertura Eventual",
                    "Celebrando em Fotografias",
                    "Momentos Memoráveis",
                    "Capturando Acontecimentos",
                    "Imortalizando Encontros",
                    "Evento em Foco",
                    "Instantes Significativos",
                    "A Arte dos Eventos"],
    4 : ["Laços Familiares em Imagens",
                    "Retratos de Carinho",
                    "Alegria Familiar Registrada",
                    "Momentos em Família",
                    "Vínculos Fotografados",
                    "Amor que Transcende",
                    "Família em Foco",
                    "União Fotográfica",
                    "Sorrisos de Família",
                    "Herança Afetiva"],
    5 : ["Comemoração em Imagens",
                        "Alegria Anual",
                        "Festejando Instantes",
                        "Aniversário em Foco",
                        "Momentos de Celebração",
                        "Capturando Sorrisos",
                        "Anos em Fotografias",
                        "Celebração Registrada",
                        "Aniversário Inesquecível",
                        "Felicidade Aniversariante"],
    6 : ["Festividades Fotografadas",
                    "A Magia das Festas",
                    "Diversão em Imagens",
                    "Festa em Foco",
                    "Risos e Alegria",
                    "Instantes Festivos",
                    "Registro de Celebrações",
                    "A Festa Perfeita",
                    "Euforia Capturada",
                    "Dança e Diversão"],
    7 : ["Vida Selvagem em Fotografias",
                    "Olhares Animais",
                    "Companheiros Peludos",
                    "Natureza em Movimento",
                    "Fotografando Bichinhos",
                    "A Beleza dos Animais",
                    "Selva em Foco",
                    "Momentos com Patas e Asas",
                    "Expressões Animais",
                    "Mundo Animal Registrado"],
    8 : ["Debutante em Destaque",
                        "Sonhos de Debutante",
                        "Quinze Anos em Imagens",
                        "Dança e Elegância",
                        "A Doce Jornada",
                        "Celebrando a Juventude",
                        "Debutante Radiante",
                        "Festa de Quinze Anos",
                        "Estilo e Beleza",
                        "Debutante em Foco"],
    9 : ["Conquistas Fotografadas",
                        "Rumo ao Futuro em Imagens",
                        "A Celebração do Saber",
                        "Graduação em Foco",
                        "Vitória Acadêmica",
                        "Momentos de Conquista",
                        "Formatura em Destaque",
                        "Orgulho Diplomado",
                        "Rituais de Formatura",
                        "Despedida com Estilo"],
    10 : ["Ação Esportiva Capturada",
                    "Energia nos Esportes",
                    "Competição em Foco",
                    "Atletismo Fotográfico",
                    "Momentos de Vitória",
                    "Jogo em Imagens",
                    "Esportes Radicais Registrados",
                    "Paixão pelo Esporte",
                    "Fotografia em Movimento",
                    "Vitória no Quadro"],
    11 : ["Horizontes em Fotografias",
                    "Beleza Natural Capturada",
                    "Cenários Deslumbrantes",
                    "Paisagens em Tranquilidade",
                    "A Arte da Natureza",
                    "Ecos do Ambiente",
                    "Explorando a Terra em Imagens",
                    "Panorama Fotográfico",
                    "Refúgios Naturais",
                    "Serena Natureza"],
    12 : ["Magia Natural em Imagens",
                    "Ecossistemas Fotográficos",
                    "Vida Selvagem em Foco",
                    "Flora e Fauna Capturadas",
                    "Ritmo Natural",
                    "Harmonia Ecológica",
                    "Natureza Intocada",
                    "Beleza Silvestre",
                    "Conexão com a Natureza",
                    "Natureza em Movimento"],
    13 : ["Estilo em Imagens",
                "Tendências Fotográficas",
                "Passarela da Vida Real",
                "Elegância em Foco",
                "Moda que Conta Histórias",
                "Estilizando Momentos",
                "Criações Fotográficas",
                "Cores da Moda",
                "Glamour Capturado",
                "Desfile de Personalidade"],
    14 : ["Roteiros Fotográficos",
                    "Aventuras pelo Mundo",
                    "Destinos em Imagens",
                    "Explorando Horizontes",
                    "Viagens que Marcam",
                    "Mochilando com a Câmera",
                    "Jornada Fotográfica",
                    "Culturas em Fotografias",
                    "Registro de Experiências",
                    "A Magia das Viagens"],
    15 : ["Sabores em Fotografias",
                        "Gastronomia Visual",
                        "Banquete de Imagens",
                        "Delícias Fotográficas",
                        "A Arte da Culinária",
                        "Sabor em Foco",
                        "Cozinha em Imagens",
                        "Gastronomia Criativa",
                        "Degustação Fotográfica",
                        "Receitas em Cada Clique"]
}

possiveis_descricoes = {
    1 : ["Momentos de amor e cumplicidade",
         "A celebração do amor em imagens",
         "A jornada do sim em fotografias",
         "A magia do amor em fotografias",
         "A celebração do amor em fotografias",
         "A jornada do sim em fotografias",
         "A magia do amor em fotografias",
         "A celebração do amor em fotografias",
         "A jornada do sim em fotografias",
         "A magia do amor em fotografias"],
    2 : ["A beleza do estilo vintage em fotografias",
            "A elegância do estilo vintage em fotografias",
            "A nostalgia do estilo vintage em fotografias",
            "A beleza do estilo vintage em fotografias",
            "A elegância do estilo vintage em fotografias",
            "A nostalgia do estilo vintage em fotografias",
            "A beleza do estilo vintage em fotografias",
            "A elegância do estilo vintage em fotografias",
            "A nostalgia do estilo vintage em fotografias",
            "A beleza do estilo vintage em fotografias"],
    3 : ["Momentos especiais em fotografias",
            "A celebração de um evento especial em fotografias",
            "A celebração de um evento especial em fotografias",
            "A celebração de um evento especial em fotografias",
            "A celebração de um evento especial em fotografias",
            "A celebração de um evento especial em fotografias",
            "A celebração de um evento especial em fotografias",
            "A celebração de um evento especial em fotografias",
            "A celebração de um evento especial em fotografias",
            "A celebração de um evento especial em fotografias"],
    4 : ["Momentos especiais em fotografias",
            "A celebração de um evento especial em fotografias",
            "A celebração de um evento especial em fotografias",
            "A celebração de um evento especial em fotografias",
            "A celebração de um evento especial em fotografias",
            "A celebração de um evento especial em fotografias",
            "A celebração de um evento especial em fotografias",
            "A celebração de um evento especial em fotografias",
            "A celebração de um evento especial em fotografias"],
    5 : ["Momentos especiais em fotografias",
            "A celebração de um evento especial em fotografias",
            "A celebração de um evento especial em fotografias"],
    6 : ["Momentos especiais em fotografias",
            "A celebração de um evento especial em fotografias"],
    7 : ["Momentos especiais em fotografias",
            "A celebração de um evento especial em fotografias"],
    8 : ["Momentos especiais em fotografias",
            "A celebração de um evento especial em fotografias"],
    9 : ["Momentos especiais em fotografias",
            "A celebração de um evento especial em fotografias"],
    10 : ["Momentos especiais em fotografias",
            "A celebração de um evento especial em fotografias"],
    11 : ["Momentos especiais em fotografias",
            "A celebração de um evento especial em fotografias"],
    12 : ["Momentos especiais em fotografias",
            "A celebração de um evento especial em fotografias"],
    13 : ["Momentos especiais em fotografias",
            "A celebração de um evento especial em fotografias"],
    14 : ["Momentos especiais em fotografias",
            "A celebração de um evento especial em fotografias"],
    15 : ["Momentos especiais em fotografias",
            "A celebração de um evento especial em fotografias"]
}





def gerar_album_aleatorio():
    tema = random.choice(list(temas_e_urls.keys()))
    urls_do_tema = temas_e_urls[tema]
    lista_de_urls = []
    for _ in range(0,3):
        imagem_aleatoria = random.choice(urls_do_tema)
        lista_de_urls.append(imagem_aleatoria)
    
    return tema, lista_de_urls



class Usuario(Base):
    __tablename__ = 'tb_usuario'
    id_usuario = Column(Integer, primary_key=True, autoincrement=True)
    nome = Column(String(120), nullable=False)
    cpf = Column(String(14))
    email = Column(String(256))
    senha = Column(String(100))
    data_nascimento = Column(Date)
    celular = Column(String(20))
    data_cadastro = Column(DateTime, default=func.now())
    tipo_usuario = Column(Integer, nullable=False)
    token_solicitacao = Column(String(200))
    cidade_preferencia = Column(String(150))
    estado_preferencia = Column(String(150))
    autenticado = Column(Integer)
    image_url = Column(String(500))
    Index('cpf', 'email', 'nome')

class Tag(Base):
    __tablename__ = 'tb_tag'
    id_tag = Column(Integer, primary_key=True, autoincrement=True)
    nome = Column(String(100), nullable=False)
    Index('nome')

class Tema(Base):
    __tablename__ = 'tb_tema'
    id_tema = Column(Integer, primary_key=True, autoincrement=True)
    nome = Column(String(50), nullable=False)
    Index('nome')

class UsuarioTag(Base):
    __tablename__ = 'tb_usuario_tag'
    id_tag = Column(Integer, ForeignKey('tb_tag.id_tag'), primary_key=True)
    id_usuario = Column(Integer, ForeignKey('tb_usuario.id_usuario'), primary_key=True)

class Album(Base):
    __tablename__ = 'tb_album'
    id_album = Column(Integer, primary_key=True, autoincrement=True)
    titulo = Column(String(150), nullable=False)
    descricao = Column(Text)
    fk_fotografo = Column(Integer, ForeignKey('tb_usuario.id_usuario'))
    fk_tema = Column(Integer, ForeignKey('tb_tema.id_tema'))
    Index('titulo')
    
class LogAcessos(Base):
    __tablename__ = 'tb_log_acessos'
    id_log_acessos = Column(Integer, primary_key=True, autoincrement=True)
    data_login = Column(DateTime, default=func.now())
    fk_usuario = Column(Integer, ForeignKey('tb_usuario.id_usuario'))
    Index('fk_usuario')
    
class LogPesquisas(Base):
    __tablename__ = 'tb_log_pesquisas'
    id_log_pesquisas = Column(Integer, primary_key=True, autoincrement=True)
    termo_busca = Column(String(150), nullable=False)
    data_pesquisa = Column(DateTime, default=func.now())
    fk_usuario = Column(Integer, ForeignKey('tb_usuario.id_usuario'))
    Index('termo_busca')
    
class Imagem(Base):
    __tablename__ = 'tb_imagem'
    id_imagem = Column(Integer, primary_key=True, autoincrement=True)
    media_url = Column(String(500))
    permalink = Column(String(500))
    caption = Column(String(100))
    media_type = Column(String(5))
    origem_imagem = Column(String(5), nullable=False)
    updated_at = Column(DateTime, default=func.now())
    fk_album = Column(Integer, ForeignKey('tb_album.id_album'))
    
class TagImagem(Base):
    __tablename__ = 'tb_tag_imagem'
    id_tag = Column(Integer, ForeignKey('tb_tag.id_tag'), primary_key=True)
    id_imagem = Column(Integer, ForeignKey('tb_imagem.id_imagem'), primary_key=True)
    
class UsuarioTema(Base):
    __tablename__ = 'tb_usuario_tema'
    id_tema = Column(Integer, ForeignKey('tb_tema.id_tema'), primary_key=True)
    id_usuario = Column(Integer, ForeignKey('tb_usuario.id_usuario'), primary_key=True)
    
class Sessao(Base):
    __tablename__ = 'tb_sessao'
    id_sessao = Column(Integer, primary_key=True, autoincrement=True)
    data_realizacao = Column(DateTime, default=func.now())
    status_sessao = Column(String(20), nullable=False)
    created_at = Column(DateTime, default=func.now())
    fk_fotografo = Column(Integer, ForeignKey('tb_usuario.id_usuario'))
    fk_cliente = Column(Integer, ForeignKey('tb_usuario.id_usuario'))
    fk_tema = Column(Integer, ForeignKey('tb_tema.id_tema'))
    Index('data_realizacao')
    
class Endereco(Base):
    __tablename__ = 'tb_endereco'
    id_endereco = Column(Integer, primary_key=True, autoincrement=True)
    cep = Column(String(10))
    logradouro = Column(String(100))
    numero = Column(String(10))
    complemento = Column(String(30))
    bairro = Column(String(80))
    cidade = Column(String(150))
    estado = Column(String(150))
    fk_sessao = Column(Integer, ForeignKey('tb_sessao.id_sessao'))
    Index('estado', 'cidade')
    
class Pagamento(Base):
    __tablename__ = 'tb_pagamento'
    id_pagamento = Column(Integer, primary_key=True, autoincrement=True)
    forma = Column(String(60), nullable=False)
    valor = Column(Float, nullable=False)
    parcelas = Column(Integer, nullable=False)
    fk_sessao = Column(Integer, ForeignKey('tb_sessao.id_sessao'))
    Index('forma', 'valor')
    
class Avaliacao(Base):
    __tablename__ = 'tb_avaliacao'
    id_avaliacao = Column(Integer, primary_key=True, autoincrement=True)
    nota = Column(Float, nullable=False)
    descricao = Column(String(300))
    fk_sessao = Column(Integer, ForeignKey('tb_sessao.id_sessao'))
    Index('nota')
    
class LogSessao(Base):
    __tablename__ = 'tb_log_sessao'
    id_log_sessao = Column(Integer, primary_key=True, autoincrement=True)
    data_modificacao = Column(DateTime, default=func.now())
    status_sessao = Column(String(20), nullable=False)
    data_realizacao = Column(DateTime, default=func.now())
    fk_sessao = Column(Integer, ForeignKey('tb_sessao.id_sessao'))
    Index('fk_sessao')

# Criação das tabelas
Base.metadata.create_all(bind=engine)

# Configuração do Faker
fake = Faker(['pt_BR'])

# Gerar e inserir dados fictícios
def gerar_dados_ficticios():
    BATCH_SIZE = 1000
    SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
    
    print(text2art('''PICME''', font="big"))
    print(text2art('''SPTECH - 2023''', font="small"))

    print('Gerando dados fictícios...')
    print('Horário de início: [', datetime.now(), ']')
    
    with SessionLocal() as db:
        
        try:
            # Adicionar Tags
            for x in listTags:
                tag = Tag(
                    nome=x
                )
                db.add(tag)
                if db.query(Tag).count() % BATCH_SIZE == 0:
                    db.commit()
                    # Iniciar uma nova transação
                    db.begin()
            db.commit()
        except Exception as e:
            print(f"Erro durante a geração de dados para Tags: {e}")
            db.rollback()

        try:
            # Adicionar Temas
            for x in listTemas:
                tema = Tema(
                    nome=x
                )
                db.add(tema)
                if db.query(Tema).count() % BATCH_SIZE == 0:
                    db.commit()
                    # Iniciar uma nova transação
                    db.begin()
            db.commit()
        except Exception as e:
            print(f"Erro durante a geração de dados para Temas: {e}")
            db.rollback()

        try:
            # Usando uma transação global
            for _ in range(50000):  # Altere conforme necessário - Para cada 10 usuários, gerar 1 fotógrafo
                usuario = Usuario(
                    nome=fake.name(),
                    cpf=fake.random_int(min=10000000000, max=99999999999),
                    email=fake.email(),
                    senha=fake.password(),
                    data_nascimento=fake.date_of_birth(),
                    celular=fake.pystr(max_chars=20),
                    tipo_usuario=1 if (_ % 10 != 9) else 2,
                    cidade_preferencia=fake.city(),
                    estado_preferencia=fake.estado_sigla(),
                    autenticado=fake.random_int(min=0, max=1),
                    token_solicitacao=fake.pystr(max_chars=200),
                    data_cadastro=fake.date_time_between(start_date="-2y", end_date="now"),
                )
                # Se o usuário for um fotógrafo, associar um álbum
                db.add(usuario)
                db.commit()

                usuario_id = usuario.id_usuario

                if usuario.tipo_usuario == 2:
                    fk_fotografo = usuario_id  # O ID do fotógrafo é o mesmo que o ID do usuário
                    fk_tema_gerado, urls = gerar_album_aleatorio()

                    for _ in range(3):  # Gerar 3 álbuns para cada fotógrafo
                        album = Album(
                            titulo=random.choice(possiveis_titulos[fk_tema_gerado]),
                            descricao=random.choice(possiveis_descricoes[fk_tema_gerado]),
                            fk_fotografo=fk_fotografo,
                            fk_tema=fk_tema_gerado
                        )
                        db.add(album)
                        db.commit()

                        for x in urls:
                            id_album = db.query(Album).filter_by(titulo=album.titulo).first().id_album
                            imagem = Imagem(
                                media_url=x,
                                permalink=fake.url(),
                                caption=fake.text(max_nb_chars=100),
                                media_type=fake.pystr(max_chars=5),
                                origem_imagem="INSTA",
                                updated_at=fake.date_time_between(start_date="-1y", end_date="now"),
                                fk_album=id_album  # Usar o ID do álbum recém-criado
                            )
                            db.add(imagem)

                    # Gerar sessões para o fotógrafo com 50% de chance
                    if fake.random_int(min=0, max=1) == 1:
                        for _ in range(fake.random_int(min=1, max=8)):  # Entre 1 e 8 sessões
                            # Inicializar o cliente com um valor inválido
                            fk_cliente = None

                            # Loop até encontrar um cliente do tipo 1
                            while fk_cliente is None or db.query(Usuario).filter_by(id_usuario=fk_cliente, tipo_usuario=1).count() == 0:
                                fk_cliente = fake.random_int(min=1, max=100)

                            sessao = Sessao(
                                data_realizacao=None,
                                status_sessao=random.choice(status_sessoes),
                                created_at=fake.date_time_between(start_date="-2y", end_date="now"),
                                fk_fotografo=fk_fotografo,
                                fk_cliente=fk_cliente,
                                fk_tema=fake.random_int(min=1, max=15)
                            )
                            
                            while sessao.data_realizacao is None or sessao.data_realizacao < sessao.created_at:
                                sessao.data_realizacao = fake.date_time_between(start_date="-2y", end_date="+1y")
                            
                            # Verificar se a sessão ocorreu no passado
                            if sessao.data_realizacao <= datetime.now():
                                # Definir o status como "Cancelada" ou "Realizada"
                                sessao.status_sessao = random.choice(["Cancelada", "Realizada"])

                            
                            db.add(sessao)
                            db.commit()  # Commit para garantir que a sessao seja inserida antes de obter o id_sessao

                            # Agora, use o id_sessao diretamente do objeto sessao
                            id_sessao = sessao.id_sessao

                            # Cada sessão deve ter um endereço
                            endereco = Endereco(
                                cep=fake.postcode(True),
                                logradouro=fake.street_name(),
                                numero=fake.building_number(),
                                complemento=fake.street_prefix(),
                                bairro=fake.neighborhood(),
                                cidade=fake.city(),
                                estado=fake.estado_sigla(),
                                fk_sessao=id_sessao
                            )
                            db.add(endereco)

                            # Cada sessão deve ter uma proposta de pagamento
                            pagamento = Pagamento(
                                forma=random.choice(listFormaPagamento),
                                valor=fake.pyfloat(min_value=0, max_value=2500),
                                parcelas=fake.random_int(min=1, max=12),
                                fk_sessao=id_sessao
                            )
                            db.add(pagamento)

                        db.commit()

                if _ % BATCH_SIZE == 0:
                    db.commit()
                    # Iniciar uma nova transação
                    db.begin()

            db.commit()
            print('Batch de usuários inseridos com sucesso!')
        except Exception as e:
            print(f"Erro durante a geração de dados para Usuários: {e}")
            db.rollback()


            
        
        try:
            for _ in range(75000):
                id_tag = fake.random_int(min=1, max=22)
                id_usuario = fake.random_int(min=1, max=50000)

                # print(f"Tentando inserir: id_tag={id_tag}, id_usuario={id_usuario}")

                usuario_tag = UsuarioTag(id_tag=id_tag, id_usuario=id_usuario)

                try:
                    if not db.query(UsuarioTag).filter_by(id_tag=id_tag, id_usuario=id_usuario).first():
                        # Inserir apenas se não existir
                        db.add(usuario_tag)

                        if _ % BATCH_SIZE == 0:
                            db.commit()
                            # Iniciar uma nova transação
                            db.begin()

                except IntegrityError as e:
                    # Lidar com a exceção (por exemplo, imprimir uma mensagem)
                    print(f"Erro de integridade: {e}")
                    db.rollback()
        except Exception as e:
            print(f"Erro durante a geração de dados: {e}")
            db.rollback()
            
        try:
            for _ in range(26000):  # Altere conforme necessário - distribuir bastante a data login
                logAcessos = LogAcessos(
                    fk_usuario=fake.random_int(min=1, max=50),
                    data_login=fake.date_time()
                )
                db.add(logAcessos)
                if _ % BATCH_SIZE == 0:
                    db.commit()
                    # Iniciar uma nova transação
                    db.begin()
            db.commit()
        except Exception as e:
            print(f"Erro durante a geração de dados: {e}")
            db.rollback()
            
        
        try:
            for _ in range(370):  # Altere conforme necessário
                logPesquisas = LogPesquisas(
                    termo_busca=fake.word(),
                    data_pesquisa=fake.date_time(between_start="-2y", between_end="now"),
                    fk_usuario=fake.random_int(min=1, max=50000)
                )
                db.add(logPesquisas)
                if _ % BATCH_SIZE == 0:
                    db.commit()
                    # Iniciar uma nova transação
                    db.begin()
            db.commit()
        except Exception as e:
            print(f"Erro durante a geração de dados: {e}")
            db.rollback()
            
        try:
            for _ in range(1500):  # Gerar um total de 18500 conexões entre tag e imagem
                while True:
                    try:
                        id_tag = fake.random_int(min=1, max=22)
                        id_imagem = fake.random_int(min=1, max=1500)

                        tag_imagem = TagImagem(
                            id_tag=id_tag,
                            id_imagem=id_imagem
                        )

                        if not db.query(TagImagem).filter_by(id_tag=id_tag, id_imagem=id_imagem).first():
                            # Inserir apenas se não existir
                            db.add(tag_imagem)

                            if _ % BATCH_SIZE == 0:
                                db.commit()
                                # Iniciar uma nova transação
                                db.begin()

                        break  # Se bem-sucedido, sai do loop

                    except IntegrityError as e:
                        # Se ocorrer uma exceção de integridade, gera novos valores e tenta novamente
                        print(f"Erro de integridade: {e}")
                        db.rollback()

            db.commit()
        except Exception as e:
            print(f"Erro durante a geração de dados: {e}")
            db.rollback()

                

            
        try:
            for _ in range(5000):  # Distribuir o interesse de temas entre os usuários
                while True:
                    try:
                        id_tema = fake.random_int(min=1, max=15)
                        id_usuario = fake.random_int(min=1, max=50000)

                        usuario_tema = UsuarioTema(
                            id_tema=id_tema,
                            id_usuario=id_usuario
                        )

                        if not db.query(UsuarioTema).filter_by(id_tema=id_tema, id_usuario=id_usuario).first():
                            # Inserir apenas se não existir
                            db.add(usuario_tema)

                            if _ % BATCH_SIZE == 0:
                                db.commit()
                                # Iniciar uma nova transação
                                db.begin()

                        break  # Se bem-sucedido, sai do loop

                    except IntegrityError as e:
                        # Se ocorrer uma exceção de integridade, gera novos valores e tenta novamente
                        print(f"Erro de integridade: {e}")
                        db.rollback()

            db.commit()
        except Exception as e:
            print(f"Erro durante a geração de dados: {e}")
            db.rollback()
            
        try:
            for _ in range(12580):  # Sessões que tiverem o status 'Realizada'
                avaliacao = Avaliacao(
                    nota=fake.pyfloat(left_digits=1, right_digits=1, positive=True, min_value=0.0, max_value=5.0),
                    descricao=fake.text(max_nb_chars=300),
                    fk_sessao=fake.random_int(min=1, max=100)
                )
                db.add(avaliacao)
                if _ % BATCH_SIZE == 0:
                    db.commit()
                     # Iniciar uma nova transação
                    db.begin()
            db.commit()
        except Exception as e:
            print(f"Erro durante a geração de dados: {e}")
            db.rollback()
            
        try:
            for _ in range(30000):  # Aleatorizar logs - não temos regra especifica
                logSessao = LogSessao(
                    data_modificacao=fake.date_time_between(start_date="-2y", end_date="now"),
                    status_sessao=random.choice(status_sessoes),
                    data_realizacao=fake.date_time_between(start_date="-2y", end_date="+2y"),
                    fk_sessao=fake.random_int(min=1, max=100)
                )
                db.add(logSessao)
                if _ % BATCH_SIZE == 0:
                    db.commit()
                     # Iniciar uma nova transação
                    db.begin()
            db.commit()
        except Exception as e:
            print(f"Erro durante a geração de dados: {e}")
            db.rollback()
            
    print('Dados fictícios gerados com sucesso!')
    print('Horário de término: [', datetime.now(), ']' )
            
            
gerar_dados_ficticios()
