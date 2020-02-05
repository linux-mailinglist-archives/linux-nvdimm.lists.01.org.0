Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE341538C2
	for <lists+linux-nvdimm@lfdr.de>; Wed,  5 Feb 2020 20:09:01 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 19A3710FC33F4;
	Wed,  5 Feb 2020 11:12:17 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F1F6D10FC33F6
	for <linux-nvdimm@lists.01.org>; Wed,  5 Feb 2020 11:12:14 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015J37vK194868;
	Wed, 5 Feb 2020 19:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Wct8jqpyHYbIbJ/a/U9jTFiDLZreDNM6tTtPbhw96Qo=;
 b=JdufFyns8hNbbWDnWIzExdzrcs9WkjN802bgygDuNbFHY4hlcldkm29SWfywVOXoi3kJ
 u/MUzUufxqyFx8R4vdUSYsie7c374WmmW3pxp5icJFfbLKuf+CeMOpkAJy7vIdXAHOLC
 G+ydFT9SCZgLkxsUEEvX8J+blkbZzuvUMsJvOXwa136/gP+eSciz6/Yta1LWdVbkswT0
 jw/IJOzX5YcCwh4dD/9yS0PxCbfMODH6VVO200wEl/Ry9+8vDUQCY1QRjvpSgTRxGINQ
 0ckR9JZxqwYYFf6PeTyyF2w3zbyr0mC0pRIE9Fvb/ne3mhuYY6QHpPbJJNQwxoPQ7/ir rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=Wct8jqpyHYbIbJ/a/U9jTFiDLZreDNM6tTtPbhw96Qo=;
 b=J0+uiMOQOHioi337n4Vy/4ihd8O60mnWRz7eE/hByGu8SzGxEk+Su0zWJ5I6CP335BBI
 BCzy3qpQFgTCufkO2bm/Dm5EThjJZq8CaJf5gGjmXV+htCeP35/79QlEVblqirpK4LV/
 TYQpkUJPwuSbWPr70x2BlOlwLceXJp4MRjyUAbhW6wmZwYhcu7ABLIrOBUzcj6huC4Lf
 69WcL0otqqbVgItICLmjpEvjJ0z/CrdQ4djFk4ictBf7w4fz377SAsYsBwst2Eo/O7PY
 tsBZvWTnmMKBV33a26n2PZDVajMAJP5BwHFleUi2ScXZOLd6uZ8Yg8Wzr/1LCh7ysvnG Ag==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2120.oracle.com with ESMTP id 2xykbp546n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2020 19:08:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015J4Njj135840;
	Wed, 5 Feb 2020 19:08:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userp3030.oracle.com with ESMTP id 2xymute872-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2020 19:08:54 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 015J8rb8015751;
	Wed, 5 Feb 2020 19:08:53 GMT
Received: from kadam (/10.175.200.151)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 05 Feb 2020 11:08:52 -0800
Date: Wed, 5 Feb 2020 22:08:45 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [bug report] libnvdimm, nvdimm: dimm driver and base libnvdimm
 device-driver infrastructure
Message-ID: <20200205190845.GD24804@kadam>
References: <20200205123826.kdvtsm47iy2ihw6r@kili.mountain>
 <CAPcyv4j12vgjgEgY3xAr9bpV8dd+3E7Q5Q3OFo2AXmwnN45PBA@mail.gmail.com>
 <20200205181040.GC24804@kadam>
 <CAPcyv4itFypOmv38Oo=DRWk_1Y3PFhPpYPDzxShmZVY9ZsTNLA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4itFypOmv38Oo=DRWk_1Y3PFhPpYPDzxShmZVY9ZsTNLA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050146
Message-ID-Hash: SWF2TGHGD3VSPHJG55ZK37IY6522QPNX
X-Message-ID-Hash: SWF2TGHGD3VSPHJG55ZK37IY6522QPNX
X-MailFrom: dan.carpenter@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SWF2TGHGD3VSPHJG55ZK37IY6522QPNX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 05, 2020 at 10:23:00AM -0800, Dan Williams wrote:
> > > >    506          if (device_add(dev) != 0) {
> > > >    507                  dev_err(dev, "%s: failed\n", __func__);
> > > >    508                  put_device(dev);
> > > >                         ^^^^^^^^^^^^^^^
> > > >    509          }
> > > >    510          put_device(dev);
> > > >                 ^^^^^^^^^^^^^^
> > > >    511          if (dev->parent)
> > > >    512                  put_device(dev->parent);
> > > >    513  }
> > > >
> > > > We call get_device() from __nd_device_register(), I guess.  It seems
> > > > buggy to call put device twice on error.
> > >
> > > The registration path does:
> > >
> > >         get_device(dev);
> > >
> > >         async_schedule_dev_domain(nd_async_device_register, dev,
> > >                                   &nd_async_domain);
> > >
> > > ...and device_add() does its own get_device().
> >
> > device_add() does its own put_device() at the end so it's a net zero.
> >
> 
> It does it's own, yes, but the put_device() after device_add() failure
> is there to drop the reference taken by device_initialize().
> Otherwise, device_add() has always documented:
> 
>  * NOTE: _Never_ directly free @dev after calling this function, even
>  * if it returned an error! Always use put_device() to give up your
>  * reference instead.
> 
> ...so what am I missing?

The "never call kfree" is hopefully straight forward because the kobject
needs to do its own cleanup.

__nvdimm_create() allocates the dev.
nd_device_register() calls device_initialize() which call kobject_init()
   so the refcount is 1.
__nd_device_register() call get_device() so the refcount is now two.
nd_async_device_register() decrements the refcount once on success.

But if device_add() fails then it decrements it twice.  Now the refcount
is zero so we call nvdimm_release().  This leads to a use after free on
the next line:

	put_device(dev);
	if (dev->parent)

There is a trick here because depending on the debug options it
might free immediately or it might call nvdimm_release() after 4
seconds.  See kobject_release() for details.

Either way if device_add() fails we return back to __nvdimm_create()
and return the zero reference count "nvdimm" pointer, which is going
to be a problem.

regards,
dan carpenter
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
