Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D4D186BAF
	for <lists+linux-nvdimm@lfdr.de>; Mon, 16 Mar 2020 14:02:56 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 81B3010096CA7;
	Mon, 16 Mar 2020 06:03:45 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A84B310096CA7
	for <linux-nvdimm@lists.01.org>; Mon, 16 Mar 2020 06:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1584363770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LLQsyKzFI2FWMsfb3WnnDbhofXGcpSrAYcxTSH7lcYc=;
	b=PtlzxOP2Th1f5yxdC8mGr5LVM7ROnrelJpm3RodragDphnbHbDd5GzbE1HTqCwU81Svf6Y
	hIVOD/0iyNx/LddJZF7x4rS21RiFaFvBsZ+iLFapmEJGX3WQUaGOEgPyVthFVOUpxmHxEx
	bKJLqJlSiwUQ4M3+NHnN+pYlrJnZLu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-qiNL0Hy_PamcS1YiC1ZLyw-1; Mon, 16 Mar 2020 09:02:44 -0400
X-MC-Unique: qiNL0Hy_PamcS1YiC1ZLyw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 722D81005516;
	Mon, 16 Mar 2020 13:02:43 +0000 (UTC)
Received: from horse.redhat.com (ovpn-121-211.rdu2.redhat.com [10.10.121.211])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AC04C92D0C;
	Mon, 16 Mar 2020 13:02:34 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 1FFCA2234E4; Mon, 16 Mar 2020 09:02:34 -0400 (EDT)
Date: Mon, 16 Mar 2020 09:02:34 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Patrick Ohly <patrick.ohly@intel.com>
Subject: Re: [PATCH 00/20] virtiofs: Add DAX support
Message-ID: <20200316130234.GA4013@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <yrjh1rpzggg4.fsf@pohly-mobl1.fritz.box>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <yrjh1rpzggg4.fsf@pohly-mobl1.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Message-ID-Hash: EPDHMOYH5GIP4PBAUPTXA6YIK5JECLDA
X-Message-ID-Hash: EPDHMOYH5GIP4PBAUPTXA6YIK5JECLDA
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EPDHMOYH5GIP4PBAUPTXA6YIK5JECLDA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 11, 2020 at 02:38:03PM +0100, Patrick Ohly wrote:
> Vivek Goyal <vgoyal@redhat.com> writes:
> > This patch series adds DAX support to virtiofs filesystem. This allows
> > bypassing guest page cache and allows mapping host page cache directly
> > in guest address space.
> >
> > When a page of file is needed, guest sends a request to map that page
> > (in host page cache) in qemu address space. Inside guest this is
> > a physical memory range controlled by virtiofs device. And guest
> > directly maps this physical address range using DAX and hence gets
> > access to file data on host.
> >
> > This can speed up things considerably in many situations. Also this
> > can result in substantial memory savings as file data does not have
> > to be copied in guest and it is directly accessed from host page
> > cache.
> 
> As a potential user of this, let me make sure I understand the expected
> outcome: is the goal to let virtiofs use DAX (for increased performance,
> etc.) or also let applications that use virtiofs use DAX?
> 
> You are mentioning using the host's page cache, so it's probably the
> former and MAP_SYNC on virtiofs will continue to be rejected, right?

Hi Patrick,

You are right. Its the former. That is we want virtiofs to be able to
make use of DAX to bypass guest page cache. But there is no persistent
memory so no persistent memory programming semantics available to user
space. For that I guess we have virtio-pmem.

We expect users will issue fsync/msync like a regular filesystem to
make changes persistent. So in that aspect, rejecting MAP_SYNC
makes sense. I will test and see if current code is rejecting MAP_SYNC
or not.

Thanks
Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
