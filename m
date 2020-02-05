Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B875C153978
	for <lists+linux-nvdimm@lfdr.de>; Wed,  5 Feb 2020 21:19:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 69BEB10FC33FE;
	Wed,  5 Feb 2020 12:22:43 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2AC3F10FC33FA
	for <linux-nvdimm@lists.01.org>; Wed,  5 Feb 2020 12:22:40 -0800 (PST)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015KIDmM070631;
	Wed, 5 Feb 2020 20:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=oyWchQmGa+e/PsKM1xMaAmbmBonLerZGgu6m4fCjdBc=;
 b=RIAq8oXQ/3/JtPgvh3S4pTLgVgKrbDMByTnfeHY0pmFhcUqRgPKpZavJhRWO+ufKns0y
 G6pTLK3WKutMSvr0p3NPDR4PFg4VaQh94p+XZuKCndmtX+VQuDPFXCgzcDukQ/h5aXVw
 P7P3XnME5YgHgRDG4C875XW2zxXhGUe3u7oO4CbhFXFmqKesk9kAZZoteAp8LDNfxIBl
 GjnaafxzO/Y0wDZj5cUD2llzV/P+jVpGoGY/1dhtOBP2cfYoQvmg5WRjwINihg/dOEZ7
 lxHgGE8mPAPTYsyyz8I4OA0TtSrjInIC9l2Rv2MwecdHXGGcPIG6lNbQ/7mK6j2WZzsQ Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=oyWchQmGa+e/PsKM1xMaAmbmBonLerZGgu6m4fCjdBc=;
 b=H6eEythnJpYlQTVSs8pSmQzapwLDQ6QuHWLLNrh2XLMSZzETAu9P66PGGESgZgx4Xhqj
 8MWDRt9Iz/K+/Vj34Gtaw6HPBtXBqzX6C3KWUWBLwiDd95A+sB5FZJRIHw+dYxqraQP/
 KcrY3Nkwt8p8tEc1pbWkPRyDV++/K3HYppljOUG0/A+spgq0haPoQ+VgU1NDdoz1C5uN
 +SDaNH+ypn1bX8Cltrvdnt/kAHGYvoVsEcW9CIkGaqnPDlxaJqOL2sqEN+T493At6Zq2
 H1+DAKlWiJzg4dTBGQ7HVo+k7qRTWDLuHQTluOj3nRcQWv7fSzTL5+eLwfhAov+qHW/g sg==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2120.oracle.com with ESMTP id 2xykbpdfw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2020 20:19:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015KJCla125765;
	Wed, 5 Feb 2020 20:19:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3020.oracle.com with ESMTP id 2xykc3s8ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2020 20:19:14 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 015KIgj1026933;
	Wed, 5 Feb 2020 20:18:42 GMT
Received: from kadam (/129.205.23.165)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 05 Feb 2020 12:18:41 -0800
Date: Wed, 5 Feb 2020 23:18:34 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [bug report] libnvdimm, nvdimm: dimm driver and base libnvdimm
 device-driver infrastructure
Message-ID: <20200205201834.GF24804@kadam>
References: <20200205123826.kdvtsm47iy2ihw6r@kili.mountain>
 <CAPcyv4j12vgjgEgY3xAr9bpV8dd+3E7Q5Q3OFo2AXmwnN45PBA@mail.gmail.com>
 <20200205181040.GC24804@kadam>
 <CAPcyv4itFypOmv38Oo=DRWk_1Y3PFhPpYPDzxShmZVY9ZsTNLA@mail.gmail.com>
 <20200205190845.GD24804@kadam>
 <CAPcyv4jkTHeS2zTmYRoFi+evMemhmMkvPVcsBOQGXinGq6JyiQ@mail.gmail.com>
 <20200205192806.GE24804@kadam>
 <CAPcyv4gySPR0+sC1-xQsXirprX96Kyk764kUOuada+6djTXUjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4gySPR0+sC1-xQsXirprX96Kyk764kUOuada+6djTXUjQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050155
Message-ID-Hash: FIYUQPZ34JWNUA3MBPJSBAMUXGEW445G
X-Message-ID-Hash: FIYUQPZ34JWNUA3MBPJSBAMUXGEW445G
X-MailFrom: dan.carpenter@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FIYUQPZ34JWNUA3MBPJSBAMUXGEW445G/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 05, 2020 at 12:04:15PM -0800, Dan Williams wrote:
> On Wed, Feb 5, 2020 at 11:28 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Wed, Feb 05, 2020 at 11:16:22AM -0800, Dan Williams wrote:
> > > Ugh, sorry I thought you were pointing out that there's too many
> > > put_device() not the use after free. Yes, the use after free is a bug
> > > that needs fixing.
> >
> > I am complaining about the device_puts...  If we call device_put()
> > twice then it cause a problem in __nvdimm_create()
> >
> > drivers/nvdimm/dimm_devs.c
> >    506          nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
> >    507          nvdimm->sec.ext_flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
> >    508          nd_device_register(dev);
> >    509
> >    510          return nvdimm;
> >                        ^^^^^^
> > If we call device_put() twice then we this pointer within 4 seconds.
> 
> "we this pointer"? We "what" this pointer. 4 seconds is relative to a
> runtime test case?
> 

Sorry.  I meant we *free* it.  The second device_put() leads to a
nvdimm_release(dev) where dev is "&nvdimm->dev" within 0-4 seconds.

Most times it will free it immediately but if you have
CONFIG_DEBUG_KOBJECT_RELEASE enabled then it will wait between 1-4
seconds and then free nvdimm.  It's a config option, not a runtime
thing.

regards,
dan carpenter
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
