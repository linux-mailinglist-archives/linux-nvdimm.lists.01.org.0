Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B542918C6BB
	for <lists+linux-nvdimm@lfdr.de>; Fri, 20 Mar 2020 06:17:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 77DC710FC36EE;
	Thu, 19 Mar 2020 22:17:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.74; helo=us-smtp-delivery-74.mimecast.com; envelope-from=xifeng@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [63.128.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B596310FC36EB
	for <linux-nvdimm@lists.01.org>; Thu, 19 Mar 2020 22:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1584681420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Jp1Q0gj9lx08D1n9OCf/luwJWZTbMfYB7HZt6ztf4E=;
	b=RGROg2aDDMdddPTpnZhmHVYyrWaLiNcP77xruWqGtRtAFAInQVMlmFPqQKxmty/Ffjw7/p
	LKl3UC4ssGu+CWQcdVyJaa1kHzdwDu8GkVdIUdOowRDGmToDQDYDEcUoXJXriu5vguVHdi
	YVnUWZfrAovi68k+83i6Og++S9EeyFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-kzx4THIyMtyrqA9sOVbTng-1; Fri, 20 Mar 2020 01:16:58 -0400
X-MC-Unique: kzx4THIyMtyrqA9sOVbTng-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0E891401;
	Fri, 20 Mar 2020 05:16:57 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CBE5E91291;
	Fri, 20 Mar 2020 05:16:57 +0000 (UTC)
Received: from zmail23.collab.prod.int.phx2.redhat.com (zmail23.collab.prod.int.phx2.redhat.com [10.5.83.28])
	by colo-mx.corp.redhat.com (Postfix) with ESMTP id A315D1809563;
	Fri, 20 Mar 2020 05:16:57 +0000 (UTC)
Date: Fri, 20 Mar 2020 01:16:57 -0400 (EDT)
From: Xiaoli Feng <xifeng@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Message-ID: <1667905528.17528206.1584681417038.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4hd_N0Hef8EysL2obYiZQA9ka_=iUt+NTjaQJVbzcME6Q@mail.gmail.com>
References: <20200320021255.1778-1-xifeng@redhat.com> <CAPcyv4h61jpnWv5eOE5u5-THXBnmRKLqeTuyPcHXKiATKFyheQ@mail.gmail.com> <1404245216.17517222.1584674311320.JavaMail.zimbra@redhat.com> <CAPcyv4hd_N0Hef8EysL2obYiZQA9ka_=iUt+NTjaQJVbzcME6Q@mail.gmail.com>
Subject: Re: [PATCH v1] test/dax.sh: correct the pmd pagefault counts
 generated by dax-pmd
MIME-Version: 1.0
X-Originating-IP: [10.72.12.163, 10.4.195.23]
Thread-Topic: test/dax.sh: correct the pmd pagefault counts generated by dax-pmd
Thread-Index: SgXu4/fX7x8gaqems0AT9uNGOLQwbw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: GLOYIPJUNX52MFS36L2WN3SPGRZXUBB7
X-Message-ID-Hash: GLOYIPJUNX52MFS36L2WN3SPGRZXUBB7
X-MailFrom: xifeng@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GLOYIPJUNX52MFS36L2WN3SPGRZXUBB7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

----- Original Message -----
> From: "Dan Williams" <dan.j.williams@intel.com>
> To: "Xiaoli Feng" <xifeng@redhat.com>
> Cc: "linux-nvdimm" <linux-nvdimm@lists.01.org>
> Sent: Friday, March 20, 2020 11:37:07 AM
> Subject: Re: [PATCH v1] test/dax.sh: correct the pmd pagefault counts generated by dax-pmd
> 
> On Thu, Mar 19, 2020 at 8:19 PM Xiaoli Feng <xifeng@redhat.com> wrote:
> >
> > Hi,
> >
> > ----- Original Message -----
> > > From: "Dan Williams" <dan.j.williams@intel.com>
> > > To: "XiaoLi Feng" <xifeng@redhat.com>
> > > Cc: "linux-nvdimm" <linux-nvdimm@lists.01.org>
> > > Sent: Friday, March 20, 2020 10:36:05 AM
> > > Subject: Re: [PATCH v1] test/dax.sh: correct the pmd pagefault counts
> > > generated by dax-pmd
> > >
> > > On Thu, Mar 19, 2020 at 7:13 PM XiaoLi Feng <xifeng@redhat.com> wrote:
> > > >
> > > > From: Xiaoli Feng <xifeng@redhat.com>
> > > >
> > > > For directIO, cannot generate pmd pagefault by pread|pwrite|read|write
> > > > if do not map fd to memory. In dax-pmd.c, case 1 and case 4 each only
> > > > generate once pmd pagefault. So change the all counts from 10 to 8.
> > >
> > > What kernel are you seeing this failure on? It's passing for me on
> > > v5.6-rc.
> >
> > I test on v4.18. I will test on v5.6.
> >
> 
> The tests are not backwards compatible with older kernels. If the
> current tests fail on an older kernel it means that older kernel is
> missing a backport of features / fixes from upstream. In this case the
> test was written as a regression test for kernel commit 6370740e5f8e
> ("fs/dax: Fix pmd vs pte conflict detection"). v4.18 precedes the
> Xarray conversion of the filesystem-dax interface which incurred other
> pmd behavior fixes so I'm not sure it will ever map correctly to that
> baseline.
> 
> At a minimum I would say you would need to carry this change in the
> distro package for ndctl that corresponds with that v4.18 kernel.

My test kernel include the patch fs/dax: Fix pmd vs pte conflict detection.
I am checking the changes from v4.18. Thanks for the info and suggestion.

> 
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
