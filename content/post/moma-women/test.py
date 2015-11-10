gender_trends = (firsts
                 .groupby(
                     [pd.Grouper(key='DateAcquired', freq='5A'), 'Gender']
                 )['DateAcquired']
                 .count()
                 .unstack())

gender_trends['percent female'] = (
    100. * gender_trends['female'] / 
    (gender_trends['male'] + gender_trends['female'])
