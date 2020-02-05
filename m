Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22B415374E
	for <lists+linux-nvdimm@lfdr.de>; Wed,  5 Feb 2020 19:10:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 03DB410FC317D;
	Wed,  5 Feb 2020 10:14:10 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CB85E10FC3171
	for <linux-nvdimm@lists.01.org>; Wed,  5 Feb 2020 10:14:08 -0800 (PST)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015I8cCD156969;
	Wed, 5 Feb 2020 18:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=vgZXPFB092P/9Z9uooh3xX3Dlg+lyN4kp19H8W61O/k=;
 b=p/MRS8FytJcMC11J+eKTAXD5MYhuEcw2SldWGtrAY4+A9OG2SrGpb5gdKgu7yfC5BXMG
 1isnGYbovKpeLSqplS291cacLtBFOWx0eSyBcyal22hINcEqKrA/iztZJR5P3x6DOSdK
 4CZaZNzOWNRnLrp40RnRZRjJjg8236fObPlh55oymwxX3oC/SceTHQDlN9gvDBEsAfo7
 oLRV//czwOQ6Bw9QRaZLokt4ozFgbXC14tBJW6eUbQ0AWeXI+0UkNdqrHk+VA+Shv/3A
 rdRutpEWUCMLMC5hNoVWhkjDKwrgQ4S/0pNdvnRaWfArd547fg9ax9cW7X+6Kxf6sDxy XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=vgZXPFB092P/9Z9uooh3xX3Dlg+lyN4kp19H8W61O/k=;
 b=ZtDuTILBSilFsdbG9GEPm5tJ5EDfvADRb55B9KODD2dr/Zr71QuAhuLAAEzaKeMn7LV7
 bqQrEU2SN7+1UFte16HuZ9z1pDG05dXKo8J+LReLSDHNYOP9whg4Z2hyztiGa3NINjZA
 dyl12NPJ4Du9m1kdyPvm25/aOh1y3LKVIfFuEMHW9v1pnt/s6lAgY74h9li1T6wJLCcN
 lHICLQ2m6/W5Cvozm9RCPX+n1c3QAEFpuHK8L3xoQcphTVpjWTl4CNmq6Z8AOGkykn96
 kCLj67VvHFtSSoI47/R0Fi2zo7R32folyVaCd+FfaMSjSBUtRH999iuOKzIYQItVq9F8 TQ==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 2xykbpcs0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2020 18:10:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015I8cpQ082829;
	Wed, 5 Feb 2020 18:10:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3030.oracle.com with ESMTP id 2xykbsf4r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2020 18:10:48 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 015IAmVR031684;
	Wed, 5 Feb 2020 18:10:48 GMT
Received: from kadam (/10.175.200.151)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 05 Feb 2020 10:10:47 -0800
Date: Wed, 5 Feb 2020 21:10:40 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [bug report] libnvdimm, nvdimm: dimm driver and base libnvdimm
 device-driver infrastructure
Message-ID: <20200205181040.GC24804@kadam>
References: <20200205123826.kdvtsm47iy2ihw6r@kili.mountain>
 <CAPcyv4j12vgjgEgY3xAr9bpV8dd+3E7Q5Q3OFo2AXmwnN45PBA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4j12vgjgEgY3xAr9bpV8dd+3E7Q5Q3OFo2AXmwnN45PBA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050140
Message-ID-Hash: GEDGHQYTSIAWQWJSSZWLSYPXUDXTQTIK
X-Message-ID-Hash: GEDGHQYTSIAWQWJSSZWLSYPXUDXTQTIK
X-MailFrom: dan.carpenter@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GEDGHQYTSIAWQWJSSZWLSYPXUDXTQTIK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 05, 2020 at 09:47:01AM -0800, Dan Williams wrote:
> On Wed, Feb 5, 2020 at 4:38 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > Hello Dan Williams,
> >
> > The patch 4d88a97aa9e8: "libnvdimm, nvdimm: dimm driver and base
> > libnvdimm device-driver infrastructure" from May 31, 2015, leads to
> > the following static checker warning:
> >
> >         drivers/nvdimm/bus.c:511 nd_async_device_register()
> >         error: dereferencing freed memory 'dev'
> >
> > drivers/nvdimm/bus.c
> >    502  static void nd_async_device_register(void *d, async_cookie_t cookie)
> >    503  {
> >    504          struct device *dev = d;
> >    505
> >    506          if (device_add(dev) != 0) {
> >    507                  dev_err(dev, "%s: failed\n", __func__);
> >    508                  put_device(dev);
> >                         ^^^^^^^^^^^^^^^
> >    509          }
> >    510          put_device(dev);
> >                 ^^^^^^^^^^^^^^
> >    511          if (dev->parent)
> >    512                  put_device(dev->parent);
> >    513  }
> >
> > We call get_device() from __nd_device_register(), I guess.  It seems
> > buggy to call put device twice on error.
> 
> The registration path does:
> 
>         get_device(dev);
> 
>         async_schedule_dev_domain(nd_async_device_register, dev,
>                                   &nd_async_domain);
> 
> ...and device_add() does its own get_device().

device_add() does its own put_device() at the end so it's a net zero.

regards,
dan carpenter
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
