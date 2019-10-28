Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B708CE792A
	for <lists+linux-nvdimm@lfdr.de>; Mon, 28 Oct 2019 20:23:51 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D27DF100EA637;
	Mon, 28 Oct 2019 12:24:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.147.86; helo=mx0a-002e3701.pphosted.com; envelope-from=prvs=0204705f9d=jerry.hoemann@hpe.com; receiver=<UNKNOWN> 
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CB1BB100EA636
	for <linux-nvdimm@lists.01.org>; Mon, 28 Oct 2019 12:24:35 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9SJKpQ8014662;
	Mon, 28 Oct 2019 19:23:44 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
	by mx0a-002e3701.pphosted.com with ESMTP id 2vx43wsm98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2019 19:23:44 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
	by g2t2354.austin.hpe.com (Postfix) with ESMTP id D2544AC;
	Mon, 28 Oct 2019 19:23:43 +0000 (UTC)
Received: from anatevka.americas.hpqcorp.net (anatevka.americas.hpqcorp.net [10.34.81.61])
	by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 52AD936;
	Mon, 28 Oct 2019 19:23:43 +0000 (UTC)
Date: Mon, 28 Oct 2019 13:23:43 -0600
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: "Kani, Toshi" <toshi.kani@hpe.com>
Subject: Re: [PATCH] uapi: Add the BSD-2-Clause license to ndctl.h
Message-ID: <20191028192343.GA6342@anatevka.americas.hpqcorp.net>
References: <20191025175553.63271-1-d.scott.phillips@intel.com>
 <CAPcyv4iQpO+JF8b7NUJUZ3fQFU=PWFeiWrXSd47QGnQPeRsrTg@mail.gmail.com>
 <38f7f4852ad1cc76c7c7473a6fda85cb9acae14c.camel@intel.com>
 <76ca7b4effada2c7219f66c211946a8178994d1c.camel@hpe.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <76ca7b4effada2c7219f66c211946a8178994d1c.camel@hpe.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-28_07:2019-10-28,2019-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=974
 clxscore=1011 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910280185
Message-ID-Hash: 66A5MVJP3VQCB73ID3OIKB7SG65T4L3Y
X-Message-ID-Hash: 66A5MVJP3VQCB73ID3OIKB7SG65T4L3Y
X-MailFrom: prvs=0204705f9d=jerry.hoemann@hpe.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "d.scott.phillips@intel.com" <d.scott.phillips@intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "stuart.w.hayes@gmail.com" <stuart.w.hayes@gmail.com>, "dhowells@redhat.com" <dhowells@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: Jerry.Hoemann@hpe.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/66A5MVJP3VQCB73ID3OIKB7SG65T4L3Y/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Oct 28, 2019 at 08:54:35AM -0600, Kani, Toshi wrote:
> On Fri, 2019-10-25 at 22:56 +0000, Verma, Vishal L wrote:
> > On Fri, 2019-10-25 at 15:45 -0700, Dan Williams wrote:
> > > On Fri, Oct 25, 2019 at 10:55 AM D Scott Phillips
> > > <d.scott.phillips@intel.com> wrote:
> > > > Allow ndctl.h to be licensed with BSD-2-Clause so that other
> > > > operating systems can provide the same user level interface.
> > > > ---
> > > > 
> > > > I've been working on nvdimm support in FreeBSD and would like to
> > > > offer the same ndctl API there to ease porting of application
> > > > code. Here I'm proposing to add the BSD-2-Clause license to this
> > > > header file, so that it can later be copied into FreeBSD.
> > > > 
> > > > I believe that all the authors of changes to this file (in the To:
> > > > list) would need to agree to this change before it could be
> > > > accepted, so any signed-off-by is intentionally ommited for now.
> > > > Thanks,
> > > 
> > > I have no problem with this change, but let's take the opportunity to
> > > let SPDX do its job and drop the full license text.
> > 
> > This is fine by me too, barring the full license text vs. SPDX caveat
> > Dan mentions.
> 
> I agree with the plan.
> 
I agree also.

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
