Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE02B132C8A
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jan 2020 18:07:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3AB4910097E09;
	Tue,  7 Jan 2020 09:11:03 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=darrick.wong@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CDD3110097E08
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jan 2020 09:11:00 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 007Gxs1i108694;
	Tue, 7 Jan 2020 17:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=TonZdKs5flBwONqESEptkzUdNDu8nb8volKmuzA6Cz0=;
 b=Dg5eAnULbmvdHQzXt/MZgtHB0R/zWD0HQ+5s3azeZp8EEZ34ay8U8IXHjZGsgK27rehS
 bb8ffV2JEBwuogOZg4wcANMgdMBKS97CpXpWk7KU7SVlPQgFUWlVHu1DAfnGryIv1LKI
 M5AvVllmupEsFvrHYTNamVFhNzc87ByL1gWOw0iTmEuPoX1/m7tYqFY+EvYYNZUwGLxG
 1Lo8F+6TNJ6Q1EeRhKR2XXV7l75GPDLV1kYwFuGmzfY9nlZh5W1Im1qMYi7elyFGtzp+
 gnwn6VDCbHk8N4C5wW46kKsyxAWes1ui6aXftOTsyPgLj2wHtLqD0FgPkvrqcDbM/whH 9A==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2120.oracle.com with ESMTP id 2xajnpxvme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jan 2020 17:07:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 007GxqZk067504;
	Tue, 7 Jan 2020 17:07:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3030.oracle.com with ESMTP id 2xcpamx72e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jan 2020 17:07:34 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 007H7XOT027070;
	Tue, 7 Jan 2020 17:07:33 GMT
Received: from localhost (/67.169.218.210)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 07 Jan 2020 09:07:33 -0800
Date: Tue, 7 Jan 2020 09:07:31 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
Message-ID: <20200107170731.GA472641@magnolia>
References: <20190821175720.25901-2-vgoyal@redhat.com>
 <20190826115152.GA21051@infradead.org>
 <20190827163828.GA6859@redhat.com>
 <20190828065809.GA27426@infradead.org>
 <20190828175843.GB912@redhat.com>
 <20190828225322.GA7777@dread.disaster.area>
 <CAPcyv4jGEAbYSJef2zLzgg6Arozsuz7eN_vZL1iTcd1XQuNT4Q@mail.gmail.com>
 <20191216181014.GA30106@redhat.com>
 <20200107125159.GA15745@infradead.org>
 <CAPcyv4jZE35sbDo6J4ihioEUFTuekJ3_h0=2Ra4PY+xn2xn1cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4jZE35sbDo6J4ihioEUFTuekJ3_h0=2Ra4PY+xn2xn1cQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001070137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001070137
Message-ID-Hash: AD6NQS2PYJM6IVTJD7O4KSSNOYKMMNWD
X-Message-ID-Hash: AD6NQS2PYJM6IVTJD7O4KSSNOYKMMNWD
X-MailFrom: darrick.wong@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Christoph Hellwig <hch@infradead.org>, Dave Chinner <david@fromorbit.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AD6NQS2PYJM6IVTJD7O4KSSNOYKMMNWD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 07, 2020 at 06:22:54AM -0800, Dan Williams wrote:
> On Tue, Jan 7, 2020 at 4:52 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Mon, Dec 16, 2019 at 01:10:14PM -0500, Vivek Goyal wrote:
> > > > Agree. In retrospect it was my laziness in the dax-device
> > > > implementation to expect the block-device to be available.
> > > >
> > > > It looks like fs_dax_get_by_bdev() is an intercept point where a
> > > > dax_device could be dynamically created to represent the subset range
> > > > indicated by the block-device partition. That would open up more
> > > > cleanup opportunities.
> > >
> > > Hi Dan,
> > >
> > > After a long time I got time to look at it again. Want to work on this
> > > cleanup so that I can make progress with virtiofs DAX paches.
> > >
> > > I am not sure I understand the requirements fully. I see that right now
> > > dax_device is created per device and all block partitions refer to it. If
> > > we want to create one dax_device per partition, then it looks like this
> > > will be structured more along the lines how block layer handles disk and
> > > partitions. (One gendisk for disk and block_devices for partitions,
> > > including partition 0). That probably means state belong to whole device
> > > will be in common structure say dax_device_common, and per partition state
> > > will be in dax_device and dax_device can carry a pointer to
> > > dax_device_common.
> > >
> > > I am also not sure what does it mean to partition dax devices. How will
> > > partitions be exported to user space.
> >
> > Dan, last time we talked you agreed that partitioned dax devices are
> > rather pointless IIRC.  Should we just deprecate partitions on DAX
> > devices and then remove them after a cycle or two?
> 
> That does seem a better plan than trying to force partition support
> where it is not needed.

Question: if one /did/ have a partitioned DAX device and used kpartx to
create dm-linear devices for each partition, will DAX still work through
that?

--D
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
