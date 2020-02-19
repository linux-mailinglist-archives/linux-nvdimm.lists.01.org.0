Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB2C163C3E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Feb 2020 05:54:56 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 27DCE10FC35A0;
	Tue, 18 Feb 2020 20:55:47 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5DD15100780A1
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 20:55:45 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01J4nLuF001002
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 23:54:52 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2y8ubwmjye-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 23:54:52 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Wed, 19 Feb 2020 04:54:49 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 19 Feb 2020 04:54:42 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01J4sf0w33161358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2020 04:54:41 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8431FA405C;
	Wed, 19 Feb 2020 04:54:41 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC425A4054;
	Wed, 19 Feb 2020 04:54:40 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed, 19 Feb 2020 04:54:40 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 3D1B7A00DF;
	Wed, 19 Feb 2020 15:54:36 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Date: Wed, 19 Feb 2020 15:54:39 +1100
In-Reply-To: <20200203142254.00007377@Huawei.com>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
	 <20191203034655.51561-15-alastair@au1.ibm.com>
	 <20200203142254.00007377@Huawei.com>
Organization: IBM Australia
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20021904-0028-0000-0000-000003DC4DB5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021904-0029-0000-0000-000024A15924
Message-Id: <3909c7f2e22f2ff275f0a2e1d1991fad061e01af.camel@au1.ibm.com>
Subject: RE: [PATCH v2 14/27] nvdimm/ocxl: Add support for near storage commands
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_08:2020-02-18,2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190031
Message-ID-Hash: VOIPL2VNJKUZXRHU5OL3WP37PB4J2C4T
X-Message-ID-Hash: VOIPL2VNJKUZXRHU5OL3WP37PB4J2C4T
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.
 ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VOIPL2VNJKUZXRHU5OL3WP37PB4J2C4T/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2020-02-03 at 14:22 +0000, Jonathan Cameron wrote:
> On Tue, 3 Dec 2019 14:46:42 +1100
> Alastair D'Silva <alastair@au1.ibm.com> wrote:
> 
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > Similar to the previous patch, this adds support for near storage
> > commands.
> > 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> >  drivers/nvdimm/ocxl/scm.c          |  6 +++++
> >  drivers/nvdimm/ocxl/scm_internal.c | 41
> > ++++++++++++++++++++++++++++++
> >  drivers/nvdimm/ocxl/scm_internal.h | 38
> > +++++++++++++++++++++++++++
> >  3 files changed, 85 insertions(+)
> > 
> > diff --git a/drivers/nvdimm/ocxl/scm.c b/drivers/nvdimm/ocxl/scm.c
> > index 1e175f3c3cf2..6c16ca7fabfa 100644
> > --- a/drivers/nvdimm/ocxl/scm.c
> > +++ b/drivers/nvdimm/ocxl/scm.c
> > @@ -310,12 +310,18 @@ static int scm_setup_command_metadata(struct
> > scm_data *scm_data)
> >  	int rc;
> >  
> >  	mutex_init(&scm_data->admin_command.lock);
> > +	mutex_init(&scm_data->ns_command.lock);
> >  
> >  	rc = scm_extract_command_metadata(scm_data,
> > GLOBAL_MMIO_ACMA_CREQO,
> >  					  &scm_data->admin_command);
> >  	if (rc)
> >  		return rc;
> >  
> > +	rc = scm_extract_command_metadata(scm_data,
> > GLOBAL_MMIO_NSCMA_CREQO,
> > +					  &scm_data->ns_command);
> > +	if (rc)
> > +		return rc;
> > +
> 
> Ah. So much for my comment in previous patch.  Ignore that...
> 
> >  	return 0;
> >  }
> >  
> > diff --git a/drivers/nvdimm/ocxl/scm_internal.c
> > b/drivers/nvdimm/ocxl/scm_internal.c
> > index 7b11b56863fb..c405f1d8afb8 100644
> > --- a/drivers/nvdimm/ocxl/scm_internal.c
> > +++ b/drivers/nvdimm/ocxl/scm_internal.c
> > @@ -132,6 +132,47 @@ int scm_admin_response_handled(const struct
> > scm_data *scm_data)
> >  				      OCXL_LITTLE_ENDIAN,
> > GLOBAL_MMIO_CHI_ACRA);
> >  }
> >  
> > +int scm_ns_command_request(struct scm_data *scm_data, u8 op_code)
> > +{
> > +	u64 val;
> > +	int rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
> > GLOBAL_MMIO_CHI,
> > +					 OCXL_LITTLE_ENDIAN, &val);
> > +	if (rc)
> > +		return rc;
> > +
> > +	if (!(val & GLOBAL_MMIO_CHI_NSCRA))
> > +		return -EBUSY;
> > +
> > +	return scm_command_request(scm_data, &scm_data->ns_command,
> > op_code);
> > +}
> > +
> > +int scm_ns_response(const struct scm_data *scm_data)
> > +{
> > +	return scm_command_response(scm_data, &scm_data->ns_command);
> > +}
> > +
> > +int scm_ns_command_execute(const struct scm_data *scm_data)
> > +{
> > +	return ocxl_global_mmio_set64(scm_data->ocxl_afu,
> > GLOBAL_MMIO_HCI,
> > +				      OCXL_LITTLE_ENDIAN,
> > GLOBAL_MMIO_HCI_NSCRW);
> > +}
> > +
> > +bool scm_ns_command_complete(const struct scm_data *scm_data)
> > +{
> > +	u64 val = 0;
> > +	int rc = scm_chi(scm_data, &val);
> > +
> > +	WARN_ON(rc);
> > +
> > +	return (val & GLOBAL_MMIO_CHI_NSCRA) != 0;
> > +}
> > +
> > +int scm_ns_response_handled(const struct scm_data *scm_data)
> > +{
> > +	return ocxl_global_mmio_set64(scm_data->ocxl_afu,
> > GLOBAL_MMIO_CHIC,
> > +				      OCXL_LITTLE_ENDIAN,
> > GLOBAL_MMIO_CHI_NSCRA);
> > +}
> > +
> >  void scm_warn_status(const struct scm_data *scm_data, const char
> > *message,
> >  		     u8 status)
> >  {
> > diff --git a/drivers/nvdimm/ocxl/scm_internal.h
> > b/drivers/nvdimm/ocxl/scm_internal.h
> > index 9bff684cd069..9575996a89e7 100644
> > --- a/drivers/nvdimm/ocxl/scm_internal.h
> > +++ b/drivers/nvdimm/ocxl/scm_internal.h
> > @@ -108,6 +108,7 @@ struct scm_data {
> >  	struct ocxl_context *ocxl_context;
> >  	void *metadata_addr;
> >  	struct command_metadata admin_command;
> > +	struct command_metadata ns_command;
> >  	struct resource scm_res;
> >  	struct nd_region *nd_region;
> >  	char fw_version[8+1];
> > @@ -176,6 +177,42 @@ int scm_admin_command_complete_timeout(const
> > struct scm_data *scm_data,
> >   */
> >  int scm_admin_response_handled(const struct scm_data *scm_data);
> >  
> > +/**
> > + * scm_ns_command_request() - Issue a near storage command request
> > + * @scm_data: a pointer to the SCM device data
> > + * @op_code: The op-code for the command
> > + * Returns an identifier for the command, or negative on error
> > + */
> > +int scm_ns_command_request(struct scm_data *scm_data, u8 op_code);
> > +
> > +/**
> > + * scm_ns_response() - Validate a near storage response
> > + * @scm_data: a pointer to the SCM device data
> > + * Returns the status code of the command, or negative on error
> > + */
> > +int scm_ns_response(const struct scm_data *scm_data);
> > +
> > +/**
> > + * scm_ns_command_execute() - Notify the controller to start
> > processing a pending near storage command
> > + * @scm_data: a pointer to the SCM device data
> > + * Returns 0 on success, negative on error
> > + */
> > +int scm_ns_command_execute(const struct scm_data *scm_data);
> > +
> > +/**
> > + * scm_ns_command_complete() - Is a near storage command executing
> > + * scm_data: a pointer to the SCM device data
> > + * Returns true if the previous admin command has completed
> > + */
> > +bool scm_ns_command_complete(const struct scm_data *scm_data);
> > +
> > +/**
> > + * scm_ns_response_handled() - Notify the controller that the near
> > storage response has been handled
> > + * scm_data: a pointer to the SCM device data
> > + * Returns 0 on success, negative on failure
> > + */
> > +int scm_ns_response_handled(const struct scm_data *scm_data);
> > +
> >  /**
> >   * scm_warn_status() - Emit a kernel warning showing a command
> > status.
> >   * @scm_data: a pointer to the SCM device data
> > @@ -184,3 +221,4 @@ int scm_admin_response_handled(const struct
> > scm_data *scm_data);
> >   */
> >  void scm_warn_status(const struct scm_data *scm_data, const char
> > *message,
> >  		     u8 status);
> > +
> Stray blank line!
Ok

> 
> Now we are into the real nitpicks.  Not enough coffee.
> 
> Jonathan
> 
-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
