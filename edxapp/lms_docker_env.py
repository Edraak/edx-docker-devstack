from .docker_common import *

SUBDOMAIN_BRANDING['edge'] = 'edge'
SUBDOMAIN_BRANDING['preview.edge'] = 'edge'

# Turn off this flag because it will render 'Edit / QA' links for all instructor viewings of
# modules. Since - for now - those links point to github (for XML based authoring), it seems broken
# to people using it. Once we can update those links to properly link back to Studio,
# then we can turn this flag back on, as well as enabling in aws.py configurations.
FEATURES['ENABLE_LMS_MIGRATION'] = False

# HOSTNAME_MODULESTORE_DEFAULT_MAPPINGS defines, as dictionary of regex's, a set of mappings of HTTP request hostnames to
# what the 'default' modulestore to use while processing the request
# for example 'preview.edx.org' should use the draft modulestore
HOSTNAME_MODULESTORE_DEFAULT_MAPPINGS = {
    'preview\.': 'draft-preferred'
}
