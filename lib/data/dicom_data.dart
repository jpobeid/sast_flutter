const List<String> listSite = ['Head & Neck', 'GU: Prostate', 'CNS: Brain'];

const List<String> listAlgo = ['Algo 1', 'Algo 2', 'Algo 3'];

const String strImage =
    '/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAA0JCgsKCA0LCwsPDg0QFCEVFBISFCgdHhghMCoyMS8qLi00O0tANDhHOS0uQllCR05QVFVUMz9dY1xSYktTVFH/2wBDAQ4PDxQRFCcVFSdRNi42UVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVH/wAARCAETARMDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD06iiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoopD1oAWivK/H3jPUrTxA1jpV60Eduu2QqAdzde47VzP8AwnPif/oLy/8AfCf4UAe9UVkeF9WXW9Atb4EF2XbIPRhwa16ACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACqGuajHpOj3V/IeIkJA9T2H51frzP4uaxiO20eJuW/eygf8AjooA8zuZ5Lq5luJWLSSMXYn1NRUUUAeifCXWfI1CbSJW+Scb489mHUfiK9Zr5r068l0+/gvITiSFw4/CvorTb2LUdOt72E5SZA4oAtUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQBHPKkEDzSsFSNSzE9gK+ePEGpvrGt3V8/SRztHovQfpXq/xQ1n+z/D32ONsTXh2cdQg6/4V4tQAUUUUALXq3wl1nzrKfSJW+aE+ZFn+6eo/P+deUVreGdWfRddtb5T8qNhx6qeDQB9D0UyKRJYkkjO5HAZSO4NPoAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACkNLWF4z1caL4bublTiVl8uL/AHjxQB5L4/1n+1/E05RswW/7qP046n865mlYlmJJyTySaSgAooooAKWkooA9r+GWs/2l4dFrI+Z7M7DnqV7GuyrwnwBrJ0fxNAXbEFx+6kz056H8692zQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFeQ/FfWftesRaZG2Y7UZf/fP+Ar1PVr+PTNMuL6U4SFC319BXzpe3Ut7ezXUzbpJXLsfc0AQmikrd8G6QdZ8SWtsRmJW8yT/dHNAFHVdJutJkgS6XaZoVmX6GqFew/FTRhd6HHfwoPMszzgfwH/CvHqACiiigBQSCCCQR0Ne+eCdYGteG7admzNGPKl/3h/jXgVd18LNZ+w64+nytiG7GFyejjp+dAHsdFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFBopsjrFG0jkKigsxPYCgDzv4t6x5Vnb6RE3zSnzJcf3R0H515Sa1fE+qtrOv3V6T8jPiMeijgVk0AFeufCbR/s2lTapIuJLk7UJ/uD/69eW6bZyahqFvZxDLzOEH419F6fZx2FhBaQjCQoEH4UAOu7eO8tJraVcxyoUYexr511fT5NL1W5sZRhoXK/UdjX0hivKvi3o/l3dvq8S/LKPKlI/vDofyoA83ooooAKltriS2uYriJtskbBlI7EVFRQB9G6FqUer6Na38Z4lQFh6N3H51oV5f8I9Zw1xo0rdf3sWf/HhXqFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFch8StZ/szw28EbYnuz5a47L3Ndea8O+I+s/2r4mkjjbMFoPKT3Pc/nQByhpKKcoLMFUZJOAKAPQPhNo/2jU5tVlXKW42Rn/aP+Ar1sVieD9IGjeHLW1IxKV3yf7x5NbdABWT4n0pdZ0C7siMuyZT2YcitaigD5ldGjkZHBDKSCD2Ipldd8SNH/svxNJLGuILseauOgPcfnXI0AFFFFAF/RdRk0nV7a/iODE4Y47juPyr6ItLmO7tYrmFg0cqB1I9DXzTmvYPhTrP2zRpNMlbMtocpnuh/wNAHeUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFBoAx/FerDRfD11eZHmBdsY9WPAr58dmdy7ElmOST3NehfFrWPP1CDSYmykA8yTH949B+A/nXnlACV1Hw90f+1vE8O9cwW376T8Og/OuYr2j4X6P/Z/h37ZIuJrxt/I5Cjp/jQB2gooFFABRRRQByHxK0f8AtPw088a5ntD5q4HJX+IflXiNfTUiLLG0bjKsCCD3Br578TaU2ja/d2JHyo+UPqp5FAGTRRRQAVveDdYOi+JLa6ZsQsfLl/3T/h1rBpaAPptWDAEHIIyD60tct8PNZ/tfw1EsjZntf3Umepx0P5V1NABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABVfULuKwsJ7yY4jhQufwqwa8++LOsfZtLh0qNiJLk75Mf3B/if5UAeW6ley6jqM97MSZJnLmqtKaSgDR0HTX1fWrWwQf61wGPovc/lX0Rbwx29vHBEu1I1CqPQAV876JrN5od4buxKCYqV3Ou7A9q3v+Fj+Jf+fiH/AL9CgD26ivEP+FkeJf8An4h/79Cj/hZHiX/n4h/79CgD2+ivEP8AhZHiX/n4h/79Cj/hZHiX/n4h/wC/QoA9vrzb4uaPvt7bV4l5jPlSkeh6GuZ/4WR4l/5+If8Av0Kr6h4613UrGWzupYXhlXaw8oUAczRRRQAUUUUAdh8NNZ/szxItvI+ILweW2egb+E/0r2yvmWN2jkV0OGU5BHY19CeFtWXW/D9reg/OV2yD0YcGgDXooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiig0AI7BVLMcKBkn0FfP3i/VzrXiK6uwcxbtkX+6OBXrPxD1n+yfDUqxttnuf3SY6jPU/lXhhoASiirFtZXV3u+zW0s2372xScUAV6Kvf2Pqn/AED7n/v0aP7G1T/oH3P/AH6NAFGir39jap/0D7n/AL9Gj+xtU/6B9z/36NAFGir39jap/wBA+5/79Gj+xtU/6B9z/wB+jQBRoq9/Y2qf9A+5/wC/Ro/sbVP+gfc/9+jQBRoq8dH1MAk6fc4H/TI1SoASiiigAr0T4Taz9n1GbSZX+S4G+PP94dR+I/lXndWdPvJdPv4LyE4khcOv4UAfSlFVdMvYtS063vYTlJow49s1aoAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACg0Vl+JdVTRdBur5iNyIRGPVjwKAPJ/ibrH9peJGto2zBZjyxjoW/iP9PwrjqfLI8srSSHc7kszHuTTKAFFe5fDrSP7K8MRO64muv3z+uD0H5fzryPwtpTaz4gtLID5Gfc/so5NfQiKqIqIAFUAADsKAHUUUUAFFFFABRRRQAUUUUAIeRg9K8D8baR/Y3ia5gUYhkPmxf7pr32uC+K+j/a9Gi1KJcyWrYf3Q/wCBoA8fooooAKUdaSigD1f4Saz5tpPo8rfNCfNiB7qeo/A/zr0avnfw1qz6LrtrfKcKj4kHqp4NfQsUiTRJLGwZHUMpHcGgB9FFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFAAa8o+LWtedewaPE/yQjzJcf3j0H4D+del6tqEOl6ZcX05wkKFvqewr531G8m1C/nvJ23STOXY/WgCvQKSpIInnmSGNSzuwVQO5NAHp/wAItJ2wXWryLy58mIn0HU/yr0oVn6DpyaTotrYoP9VGAx9W7n860KACiiigAooooAKKKKACiiigAqC9tY72zmtZhmOVCjD2IqeigD5u1Wxk03U7mylB3QyFPr6Gqdei/FvR/JvrfVolwsw8uT/eHQ/lXnVABRRRQAor2r4Y61/aXh4Wkr5nszsOe6fwn+leKV03gHWv7G8SwM7Yt7j9zL6YPQ/nQB7vRSCloAKKKKACiiigAooooAKKKKACiiigAoPSisTxR4jtPD2mPPM4M7DEMWeXP+FAHEfFjXtzw6JA/C4lnx6/wj+tea1Ne3U19dy3Vw5eaVi7se5NQUALXVfDfThqHi2BnGUtwZiD6jp+prlK7/4RXMMeuXcD4EksPyZ74PNAHrwopBS0AFFFFABRRRQAUUUUAFFFFABRRRQBz3jnThqXhS9i25eNfNT6rzXglfTE6rJBIj8KykHPpivmy7RY7uZEOVV2APtmgCGiiigApRweDikooA938Ba6Nb8OxNI4Nzb/ALqUd+Oh/EV01eB+C/ETeHtbSZyTay/JOo/u+v1Fe8W80VxAk8MiyRONyupyCKAJKKKKACiiigAooooAKKKKACub8X+LI/DCW5e0a4M+cYfbjFdJXmXxj/1emfV/6UAZuofFLVZ1KWVrBbA9HPzt+vFcVfX11qFy1xeTvPM3VnOarUUAFFFFABUtvcTWs6TwStFKhyrocEGoqKAO1sPiZr1qqrOILoAYzIuCfqRWvb/FmQD/AEjSVJ7+XJj+deZ0UAfR+iaiur6Tb6gkRiWddwQnJFXqwPA3/Inab/1y/rW/QAUUUUAFFFFABRRRQBx/izxzH4b1BbI2DTu0YcNvwPyxXLz/ABYvySINNt1HYsxJqp8Wv+Rni/64D+ZrhaAOp1H4geIdQieE3KwRvwREgBx6ZrlyaSigAooooAKKKKAFFbGi+J9X0P5bG7ZYuvlP8yfkaxqKAPR7L4r3SgC902OTHUxOVJ/OvQ/D2rprujw6jHC0Ky5+RjkjBx1r51r3T4bf8iVZfV//AEI0AdTRRRQAUUUUAFFFFABWZrGgaZrYi/tG2E3lZ28kYz9K06KAOZ/4QLwz/wBA4f8Afbf40f8ACA+Gf+gcP++2/wAa6aigDmf+EB8M/wDQOH/fbf40f8ID4Z/6Bw/77b/GumooA5n/AIQHwz/0Dh/323+NH/CA+Gf+gcP++2/xrpqKAOZ/4QHwz/0Dh/323+NL/wAIF4Z/6Bo/77b/ABrpaKAK9jZ2+n2cdpax+XDGMKuegqxRRQAUUUUAFFFFABRRRQBj6r4Y0fWLoXN/aCaULtDbiOPwqj/wgXhn/oHD/vtv8a6aigDmf+EB8M/9A4f99t/jR/wgPhn/AKBw/wC+2/xrpqKAOZ/4QHwz/wBA4f8Afbf40f8ACA+Gf+gcP++2/wAa6aigDmf+EB8M/wDQOH/fbf40f8ID4Z/6Bw/77b/GumooA5n/AIQHwz/0Dh/323+NH/CA+Gf+gcP++2/xrpqKAOa/4QLwz/0Dh/323+Nbem6da6XZJZ2UXlQJkquc4yc1aooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigD/2Q==';
