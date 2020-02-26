Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D3516F991
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Feb 2020 09:26:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 51C2E10FC3609;
	Wed, 26 Feb 2020 00:27:44 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=66.55.73.32; helo=ushosting.nmnhosting.com; envelope-from=alastair@d-silva.org; receiver=<UNKNOWN> 
Received: from ushosting.nmnhosting.com (ushosting.nmnhosting.com [66.55.73.32])
	by ml01.01.org (Postfix) with ESMTP id 5818C10FC3607
	for <linux-nvdimm@lists.01.org>; Wed, 26 Feb 2020 00:27:41 -0800 (PST)
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
	by ushosting.nmnhosting.com (Postfix) with ESMTPS id 014E52DC00E4;
	Wed, 26 Feb 2020 19:26:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
	s=201810a; t=1582705607;
	bh=80fBdwbzVEqAw+uYKkj4SQtkzUXen9bXvqaTYfSOk4E=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
	b=DPOwD4usPhiADwX4LI+zMnTd9uY8z9YYAZjTUDt4Pk1kBy0kYipEm2MbZ9x7pzd+S
	 vKSVZd0g/6FbaM+mhA4ND9DXwPuLJQOARTy2MgpzzpNIoce5F2z1PoFzI9/G5x3T8a
	 +cZZj3w+7uGbzs4eIOF7ISrc08Rs4+FdNOMQFVZUnjpvI5QS76UdyK7gUXCjtGZNct
	 JI4Ew83JuGXQhdPeuFD3lFR68o0jsejd3QQzICIhfG/wItMM7jzvfe64YF0LQi+9Q/
	 1DsKVAmOjw4iRnSL0MdsYAsvSPDCocIH8jz3iK1EBWBLA7j8XvrWkT66tjMbsrHFHc
	 0zpVeFUiQSU/Upu5EWV9o/y34hId+fdsj0eS1lkWMfpm//es540N4o0XAUEE6rsWUO
	 vs4C2osTrvq2wEP8HzoapDqWJ6GslVFq4JcPH5HbSaifCbji1tF5h+hIbJUcPeeLAJ
	 6RpKY35T0y6KvgJkI3rVmWaZB5pYdQgCf/mvlc5YorK/OB1ATWO3r8fupn8GowdeuJ
	 /pjGI7Hxv+CFYFUA7MyhU9j4LYYbx7H4qd+LvSY8zWvGHqW6AIT8Zrw64dsqAjpFxq
	 G6HSY4vre1yuYynt+TqqVL9ZYyNyoX8loNaMKbnRQUjSOnte3r+TBEp4dEZAC4seWF
	 8ckmiALC5R6ZSO8+PgWwl8io=
Received: from Hawking (ntp.lan [10.0.1.1])
	(authenticated bits=0)
	by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTPSA id 01Q8QXFx062720
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 26 Feb 2020 19:26:34 +1100 (AEDT)
	(envelope-from alastair@d-silva.org)
From: "Alastair D'Silva" <alastair@d-silva.org>
To: "'Baoquan He'" <bhe@redhat.com>,
        "'Alastair D'Silva'" <alastair@au1.ibm.com>
References: <20200221032720.33893-1-alastair@au1.ibm.com> <20200221032720.33893-5-alastair@au1.ibm.com> <20200226081447.GH4937@MiWiFi-R3L-srv>
In-Reply-To: <20200226081447.GH4937@MiWiFi-R3L-srv>
Subject: RE: [PATCH v3 04/27] ocxl: Remove unnecessary externs
Date: Wed, 26 Feb 2020 19:26:34 +1100
Message-ID: <4d49801d5ec7e$7a3e8610$6ebb9230$@d-silva.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFvwBELB7thA+Ae3jvxFm54+bhaEQJqYraXAhSTffeo1YSXcA==
Content-Language: en-au
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Wed, 26 Feb 2020 19:26:42 +1100 (AEDT)
Message-ID-Hash: 2BE5PQSRER7JMQ26NGZAZTG5TAJFS5GZ
X-Message-ID-Hash: 2BE5PQSRER7JMQ26NGZAZTG5TAJFS5GZ
X-MailFrom: alastair@d-silva.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "'Aneesh Kumar K . V'" <aneesh.kumar@linux.ibm.com>, 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, 'Paul Mackerras' <paulus@samba.org>, 'Michael Ellerman' <mpe@ellerman.id.au>, 'Frederic Barrat' <fbarrat@linux.ibm.com>, 'Andrew Donnellan' <ajd@linux.ibm.com>, 'Arnd Bergmann' <arnd@arndb.de>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Mauro Carvalho Chehab' <mchehab+samsung@kernel.org>, "'David S. Miller'" <davem@davemloft.net>, 'Rob Herring' <robh@kernel.org>, 'Anton Blanchard' <anton@ozlabs.org>, 'Krzysztof Kozlowski' <krzk@kernel.org>, 'Mahesh Salgaonkar' <mahesh@linux.vnet.ibm.com>, 'Madhavan Srinivasan' <maddy@linux.vnet.ibm.com>, =?iso-8859-1?Q?'C=E9dric_Le_Goater'?= <clg@kaod.org>, 'Anju T Sudhakar' <anju@linux.vnet.ibm.com>, 'Hari Bathini' <hbathini@linux.ibm.com>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Greg Kurz' <groug@kaod.org>, 'Nicholas Piggin' <npiggin@gmail.com>, 'Masahiro Yamada' <yamada.masahiro@socion
 ext.com>, 'Alexey Kardashevskiy' <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2BE5PQSRER7JMQ26NGZAZTG5TAJFS5GZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Baoquan He <bhe@redhat.com>
> Sent: Wednesday, 26 February 2020 7:15 PM
> To: Alastair D'Silva <alastair@au1.ibm.com>
> Cc: alastair@d-silva.org; Aneesh Kumar K . V
> <aneesh.kumar@linux.ibm.com>; Oliver O'Halloran <oohall@gmail.com>;
> Benjamin Herrenschmidt <benh@kernel.crashing.org>; Paul Mackerras
> <paulus@samba.org>; Michael Ellerman <mpe@ellerman.id.au>; Frederic
> Barrat <fbarrat@linux.ibm.com>; Andrew Donnellan <ajd@linux.ibm.com>;
> Arnd Bergmann <arnd@arndb.de>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Dan Williams <dan.j.williams@intel.com>;
> Vishal Verma <vishal.l.verma@intel.com>; Dave Jiang
> <dave.jiang@intel.com>; Ira Weiny <ira.weiny@intel.com>; Andrew Morton
> <akpm@linux-foundation.org>; Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org>; David S. Miller <davem@davemloft.net>;
> Rob Herring <robh@kernel.org>; Anton Blanchard <anton@ozlabs.org>;
> Krzysztof Kozlowski <krzk@kernel.org>; Mahesh Salgaonkar
> <mahesh@linux.vnet.ibm.com>; Madhavan Srinivasan
> <maddy@linux.vnet.ibm.com>; C=E9dric Le Goater <clg@kaod.org>; Anju T
> Sudhakar <anju@linux.vnet.ibm.com>; Hari Bathini
> <hbathini@linux.ibm.com>; Thomas Gleixner <tglx@linutronix.de>; Greg
> Kurz <groug@kaod.org>; Nicholas Piggin <npiggin@gmail.com>; Masahiro
> Yamada <yamada.masahiro@socionext.com>; Alexey Kardashevskiy
> <aik@ozlabs.ru>; linux-kernel@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; linux-nvdimm@lists.01.org; linux-mm@kvack.org
> Subject: Re: [PATCH v3 04/27] ocxl: Remove unnecessary externs
>=20
> On 02/21/20 at 02:26pm, Alastair D'Silva wrote:
> > From: Alastair D'Silva <alastair@d-silva.org>
> >
> > Function declarations don't need externs, remove the existing ones so
> > they are consistent with newer code
> >
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> >  arch/powerpc/include/asm/pnv-ocxl.h | 32 ++++++++++++++---------------
> >  include/misc/ocxl.h                 |  6 +++---
> >  2 files changed, 18 insertions(+), 20 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/pnv-ocxl.h
> > b/arch/powerpc/include/asm/pnv-ocxl.h
> > index 0b2a6707e555..b23c99bc0c84 100644
> > --- a/arch/powerpc/include/asm/pnv-ocxl.h
> > +++ b/arch/powerpc/include/asm/pnv-ocxl.h
> > @@ -9,29 +9,27 @@
> >  #define PNV_OCXL_TL_BITS_PER_RATE       4
> >  #define PNV_OCXL_TL_RATE_BUF_SIZE
> ((PNV_OCXL_TL_MAX_TEMPLATE+1) * PNV_OCXL_TL_BITS_PER_RATE / 8)
> >
> > -extern int pnv_ocxl_get_actag(struct pci_dev *dev, u16 *base, u16
> *enabled,
> > -			u16 *supported);
>=20
> It works w or w/o extern when declare functions. Searching 'extern'
> under include can find so many functions with 'extern' adding. Do we have
a
> explicit standard if we should add or remove 'exter' in function
declaration?
>=20
> I have no objection to this patch, just want to make clear so that I can
handle
> it w/o confusion.
>=20
> Thanks
> Baoquan
>=20

For the OpenCAPI driver, we have settled on not having 'extern' on
functions.

I don't think I've seen a standard that supports or refutes this, but it
does not value add.

--=20
Alastair D'Silva           mob: 0423 762 819
skype: alastair_dsilva     msn: alastair@d-silva.org
blog: http://alastair.d-silva.org    Twitter: @EvilDeece



_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
