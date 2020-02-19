Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6DB163C52
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Feb 2020 06:02:50 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D57C010FC35A4;
	Tue, 18 Feb 2020 21:03:41 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D01A410FC35A4
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 21:03:39 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01J50HX8131862
	for <linux-nvdimm@lists.01.org>; Wed, 19 Feb 2020 00:02:46 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2y8ubrms8m-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Wed, 19 Feb 2020 00:02:46 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Wed, 19 Feb 2020 05:02:43 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 19 Feb 2020 05:02:37 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01J51es032047418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2020 05:01:41 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C8C9AE056;
	Wed, 19 Feb 2020 05:02:36 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4EDAAE05D;
	Wed, 19 Feb 2020 05:02:35 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed, 19 Feb 2020 05:02:35 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 28E0EA00DF;
	Wed, 19 Feb 2020 16:02:31 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Date: Wed, 19 Feb 2020 16:02:34 +1100
In-Reply-To: <20200203151148.00000ae0@Huawei.com>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
	 <20191203034655.51561-23-alastair@au1.ibm.com>
	 <20200203151148.00000ae0@Huawei.com>
Organization: IBM Australia
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20021905-0012-0000-0000-0000038826FF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021905-0013-0000-0000-000021C4B959
Message-Id: <d5038cb1f1f4517c2691e85dfdc379bb6848a0db.camel@au1.ibm.com>
Subject: RE: [PATCH v2 22/27] nvdimm/ocxl: Implement the heartbeat command
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_08:2020-02-18,2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0 spamscore=0
 mlxlogscore=937 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002190033
Message-ID-Hash: 7WW3SA5TO3QIATZME3ZJHAW5PS5CUTEK
X-Message-ID-Hash: 7WW3SA5TO3QIATZME3ZJHAW5PS5CUTEK
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.
 ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7WW3SA5TO3QIATZME3ZJHAW5PS5CUTEK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2020-02-03 at 15:11 +0000, Jonathan Cameron wrote:
> On Tue, 3 Dec 2019 14:46:50 +1100
> Alastair D'Silva <alastair@au1.ibm.com> wrote:
> 
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > The heartbeat admin command is a simple admin command that
> > exercises
> > the communication mechanisms within the controller.
> > 
> > This patch issues a heartbeat command to the card during init to
> > ensure
> > we can communicate with the card's crontroller.
> 
> controller

That's a perfectly cromulent misspelling ;)

> 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> >  drivers/nvdimm/ocxl/scm.c | 43
> > +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> > 
> > diff --git a/drivers/nvdimm/ocxl/scm.c b/drivers/nvdimm/ocxl/scm.c
> > index 8a30c887b5ed..e8b34262f397 100644
> > --- a/drivers/nvdimm/ocxl/scm.c
> > +++ b/drivers/nvdimm/ocxl/scm.c
> > @@ -353,6 +353,44 @@ static bool scm_is_usable(const struct
> > scm_data *scm_data)
> >  	return true;
> >  }
> >  
> > +/**
> > + * scm_heartbeat() - Issue a heartbeat command to the controller
> > + * @scm_data: a pointer to the SCM device data
> > + * Return: 0 if the controller responded correctly, negative on
> > error
> > + */
> > +static int scm_heartbeat(struct scm_data *scm_data)
> > +{
> > +	int rc;
> > +
> > +	mutex_lock(&scm_data->admin_command.lock);
> > +
> > +	rc = scm_admin_command_request(scm_data,
> > ADMIN_COMMAND_HEARTBEAT);
> > +	if (rc)
> > +		goto out;
> > +
> > +	rc = scm_admin_command_execute(scm_data);
> > +	if (rc)
> > +		goto out;
> > +
> > +	rc = scm_admin_command_complete_timeout(scm_data,
> > ADMIN_COMMAND_HEARTBEAT);
> > +	if (rc < 0) {
> > +		dev_err(&scm_data->dev, "Heartbeat timeout\n");
> > +		goto out;
> > +	}
> > +
> > +	rc = scm_admin_response(scm_data);
> > +	if (rc < 0)
> > +		goto out;
> > +	if (rc != STATUS_SUCCESS)
> > +		scm_warn_status(scm_data, "Unexpected status from
> > heartbeat", rc);
> > +
> > +	rc = scm_admin_response_handled(scm_data);
> > +
> > +out:
> > +	mutex_unlock(&scm_data->admin_command.lock);
> > +	return rc;
> > +}
> > +
> >  /**
> >   * allocate_scm_minor() - Allocate a minor number to use for an
> > SCM device
> >   * @scm_data: The SCM device to associate the minor with
> > @@ -1508,6 +1546,11 @@ static int scm_probe(struct pci_dev *pdev,
> > const struct pci_device_id *ent)
> >  		goto err;
> >  	}
> >  
> > +	if (scm_heartbeat(scm_data)) {
> > +		dev_err(&pdev->dev, "SCM Heartbeat failed\n");
> > +		goto err;
> > +	}
> > +
> >  	elapsed = 0;
> >  	timeout = scm_data->readiness_timeout + scm_data-
> > >memory_available_timeout;
> >  	while (!scm_is_usable(scm_data)) {
-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
