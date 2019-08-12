Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA908A94F
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Aug 2019 23:29:28 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3DC3521311C05;
	Mon, 12 Aug 2019 14:31:46 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=jmoyer@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C84B12130309C
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 14:31:44 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CBB40C05AA57;
 Mon, 12 Aug 2019 21:29:25 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com
 (segfault.boston.devel.redhat.com [10.19.60.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 233026A225;
 Mon, 12 Aug 2019 21:29:24 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] mm/memremap: Fix reuse of pgmap instances with internal
 references
References: <156530042781.2068700.8733813683117819799.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49blwuidqn.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4jZWbBUrig3wnE+VGptMEv3fHeRJbRhmMncQwkjLUbvxg@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Mon, 12 Aug 2019 17:29:24 -0400
In-Reply-To: <CAPcyv4jZWbBUrig3wnE+VGptMEv3fHeRJbRhmMncQwkjLUbvxg@mail.gmail.com>
 (Dan Williams's message of "Mon, 12 Aug 2019 09:44:10 -0700")
Message-ID: <x49ftm6gjij.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 12 Aug 2019 21:29:25 +0000 (UTC)
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Linux MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
 Jason Gunthorpe <jgg@mellanox.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Dan Williams <dan.j.williams@intel.com> writes:

> On Mon, Aug 12, 2019 at 8:51 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>>
>> Dan Williams <dan.j.williams@intel.com> writes:
>>
>> > Currently, attempts to shutdown and re-enable a device-dax instance
>> > trigger:
>>
>> What does "shutdown and re-enable" translate to?  If I disable and
>> re-enable a device-dax namespace, I don't see this behavior.
>
> I was not seeing this either until I made sure I was in 'bus" device model mode.
>
> # cat /etc/modprobe.d/daxctl.conf
> blacklist dax_pmem_compat
> alias nd:t7* dax_pmem
>
> # make TESTS="daxctl-devices.sh" check -j 40 2>out
>
> # dmesg | grep WARN.*devm
> [  225.588651] WARNING: CPU: 10 PID: 9103 at mm/memremap.c:211
> devm_memremap_pages+0x234/0x850
> [  225.679828] WARNING: CPU: 10 PID: 9103 at mm/memremap.c:211
> devm_memremap_pages+0x234/0x850

Ah, you see this when reconfiguring the device.  So, the lifetime of the
pgmap is tied to the character device, which doesn't get torn down.  The
fix looks good to me, and tests out fine.

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
