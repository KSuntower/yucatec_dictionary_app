# yucatec_dictionary_app

A simple dictionary application for the Yucatec Maya language.

# DISCLAIMER
- The provided database only contains a few words.
- The app is currently only in spanish, i'm writting this in english because it is easier to spellcheck.

# BUILDING
if you want to build the app yourself you need to provide your own database for the dictionary words. The database needs to have
the same structure as the one below.

```sql
CREATE TABLE contents (Flags String, WordYuc String, Definition Text, Single String, Example Text, WordEsp String, Categories String)
```

- **Flags** refers to the a semicolon separated list to determine the conjugation of verbs, if the entry can't be conjugated it is left empty.
- **WordYuc** referes to a single word entry in Yucatec Maya.
- **Definition** referes to the Spanish definition of the word, this can be multiple lines and needs to be separated with semicolons.
- **Single** refers to a list of single word entries in Spanish.
- **Example** refers to one or a semicolon separated list of example texts in Yucatec Maya
- **WordEsp** refers to the translation of the example texts also separated with semicolons.
- **Categories** refers to a comma separated list of available categories.

The fonts used in this project aren't provided in this repo, they can be found on the Google Fonts website. The list is below:
- Dosis
- Prata
