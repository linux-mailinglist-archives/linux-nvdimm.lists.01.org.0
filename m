Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F0F16F463
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Feb 2020 01:35:43 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2CD1410FC36D4;
	Tue, 25 Feb 2020 16:36:33 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B1BBC10FC36D3
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 16:36:30 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01Q0ZAD8080553
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 19:35:38 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ydcnt2dga-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 19:35:38 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Wed, 26 Feb 2020 00:35:34 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 26 Feb 2020 00:35:28 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01Q0ZRs843254056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2020 00:35:27 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BA844C04E;
	Wed, 26 Feb 2020 00:35:27 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE81D4C044;
	Wed, 26 Feb 2020 00:35:26 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed, 26 Feb 2020 00:35:26 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 138A1A00F1;
	Wed, 26 Feb 2020 11:35:22 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 26 Feb 2020 11:35:25 +1100
In-Reply-To: <CAPcyv4g_762vho=L21BuO=97zr9Cq14np88bnFieiYN25BvJtA@mail.gmail.com>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
	 <CAPcyv4j2hut1YDrotC=QkcM+S0SZwpd9_4hD2aChn+cKD+62oA@mail.gmail.com>
	 <240fbefc6275ac0a6f2aa68715b3b73b0e7a8310.camel@au1.ibm.com>
	 <20200224043750.GM24185@bombadil.infradead.org>
	 <83034494d5c3da1fa63b172e844f85d0fec7910a.camel@au1.ibm.com>
	 <CAOSf1CHYEJf02EV0kYMk+D9s=4PiTXSM1eFcRGYe7XJrHvtAtA@mail.gmail.com>
	 <b981f4e6cc308a617e7944e3ce23009e804cfdbf.camel@au1.ibm.com>
	 <CAPcyv4g_762vho=L21BuO=97zr9Cq14np88bnFieiYN25BvJtA@mail.gmail.com>
Organization: IBM Australia
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022600-0012-0000-0000-0000038A44FB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022600-0013-0000-0000-000021C6E901
Message-Id: <0e605b595cd03ef34c41a0b3d2304d7fb3ed7690.camel@au1.ibm.com>
Subject: RE: [PATCH v3 00/27] Add support for OpenCAPI Persistent Memory devices
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_09:2020-02-25,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002260001
Message-ID-Hash: FK3HD5GZ2FT4DAF3JBC4ZFB4YBL5U75M
X-Message-ID-Hash: FK3HD5GZ2FT4DAF3JBC4ZFB4YBL5U75M
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Matthew Wilcox <willy@infradead.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>
 , Alexey Kardashevskiy <aik@ozlabs.ru>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FK3HD5GZ2FT4DAF3JBC4ZFB4YBL5U75M/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2020-02-25 at 16:32 -0800, Dan Williams wrote:
> On Tue, Feb 25, 2020 at 4:14 PM Alastair D'Silva <
> alastair@au1.ibm.com> wrote:
> > On Mon, 2020-02-24 at 17:51 +1100, Oliver O'Halloran wrote:
> > > On Mon, Feb 24, 2020 at 3:43 PM Alastair D'Silva <
> > > alastair@au1.ibm.com> wrote:
> > > > On Sun, 2020-02-23 at 20:37 -0800, Matthew Wilcox wrote:
> > > > > On Mon, Feb 24, 2020 at 03:34:07PM +1100, Alastair D'Silva
> > > > > wrote:
> > > > > > V3:
> > > > > >   - Rebase against next/next-20200220
> > > > > >   - Move driver to arch/powerpc/platforms/powernv, we now
> > > > > > expect
> > > > > > this
> > > > > >     driver to go upstream via the powerpc tree
> > > > > 
> > > > > That's rather the opposite direction of normal; mostly
> > > > > drivers
> > > > > live
> > > > > under
> > > > > drivers/ and not in arch/.  It's easier for drivers to get
> > > > > overlooked
> > > > > when doing tree-wide changes if they're hiding.
> > > > 
> > > > This is true, however, given that it was not all that desirable
> > > > to
> > > > have
> > > > it under drivers/nvdimm, it's sister driver (for the same
> > > > hardware)
> > > > is
> > > > also under arch, and that we don't expect this driver to be
> > > > used on
> > > > any
> > > > platform other than powernv, we think this was the most
> > > > reasonable
> > > > place to put it.
> > > 
> > > Historically powernv specific platform drivers go in their
> > > respective
> > > subsystem trees rather than in arch/ and I'd prefer we kept it
> > > that
> > > way. When I added the papr_scm driver I put it in the pseries
> > > platform
> > > directory because most of the pseries paravirt code lives there
> > > for
> > > some reason; I don't know why. Luckily for me that followed the
> > > same
> > > model that Dan used when he put the NFIT driver in drivers/acpi/
> > > and
> > > the libnvdimm core in drivers/nvdimm/ so we didn't have anything
> > > to
> > > argue about. However, as Matthew pointed out, it is at odds with
> > > how
> > > most subsystems operate. Is there any particular reason we're
> > > doing
> > > things this way or should we think about moving libnvdimm users
> > > to
> > > drivers/nvdimm/?
> > > 
> > > Oliver
> > 
> > I'm not too fussed where it ends up, as long as it ends up
> > somewhere :)
> > 
> > From what I can tell, the issue is that we have both
> > "infrastructure"
> > drivers, and end-device drivers. To me, it feels like
> > drivers/nvdimm
> > should contain both, and I think this feels like the right
> > approach.
> > 
> > I could move it back to drivers/nvdimm/ocxl, but I felt that it was
> > only tolerated there, not desired. This could be cleared up with a
> > response from Dan Williams, and if it is indeed dersired, this is
> > my
> > preferred location.
> 
> Apologies if I gave the impression it was only tolerated. I'm ok with
> drivers/nvdimm/ocxl/, and to the larger point I'd also be ok with a
> drivers/{acpi => nvdimm}/nfit and {arch/powerpc/platforms/pseries =>
> drivers/nvdimm}/papr_scm.c move as well to keep all the consumers of
> the nvdimm related code together with the core.

Great, thanks for clarifying, text is so imprecise when it comes to
nuance :)

I'll move ti back to drivers/nvdimm/ocxl then.

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
