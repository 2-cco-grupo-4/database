import random
from datetime import date

def generate_insert(log_id, active_session, session_duration, session_date, new_session_qty, total_page_views, log_page_site):
    return f"INSERT INTO LOG_PAGINA_SITE (ID_LOG_PAGINA_SITE, SESSAO_ATIVA, TEMPO_DURACAO_SESSAO, DATA_SESSAO, QTD_NOVA_SESSAO, TOTAL_VIEW_PAGINA, LOG_PAGINA_SITECOL) " \
           f"VALUES ({log_id}, {active_session}, {session_duration}, '{session_date}', {new_session_qty}, {total_page_views}, '{log_page_site}');"

def generate_random_data(num_logs):
    data = []
    for log_id in range(1, num_logs + 1):
        active_session = random.randint(0, 1)
        session_duration = round(random.uniform(1.0, 60.0),2)  # Em segundos
        session_date = date.today()
        new_session_qty = random.randint(1, 10)
        total_page_views = random.randint(1, 100)
        log_page_site = f"Pagina {log_id}"
        insert = generate_insert(log_id, active_session, session_duration, session_date, new_session_qty, total_page_views, log_page_site)
        data.append(insert)
    return data

def write_to_file(filename, data):
    with open(filename, 'w') as file:
        for insert in data:
            file.write(insert + '\n')

num_logs = 100
filename = 'dadosLogPaginaSite.txt'

random_data = generate_random_data(num_logs)
write_to_file(filename, random_data)

print(f"Inserts gerados e salvos no arquivo '{filename}'.")
