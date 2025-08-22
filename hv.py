import sys, re

def emit_insert(schema_table, cols, fields):
    vals = []
    for v in fields:
        if v == r'\N':
            vals.append('NULL')
        else:
            vals.append("'" + v.replace("'", "''") + "'")
    return f"INSERT INTO {schema_table} ({', '.join(cols)}) VALUES ({', '.join(vals)});"

copy_re = re.compile(r'^COPY\s+([^\s]+)\s*\(([^)]+)\)\s+FROM\s+stdin;', re.IGNORECASE)
table = None
cols = []
for line in open(sys.argv[1], 'r', encoding='utf-8', errors='ignore'):
    line = line.rstrip('\n')
    if table is None:
        m = copy_re.match(line)
        if m:
            table = m.group(1)  # e.g., public.attendances
            cols = [c.strip() for c in m.group(2).split(',')]
        continue
    if line == r'\.':
        table = None
        cols = []
        continue
    if line.startswith('--') or not line:
        continue
    # COPY rows are tab-delimited
    fields = line.split('\t')
    print(emit_insert(table, cols, fields))