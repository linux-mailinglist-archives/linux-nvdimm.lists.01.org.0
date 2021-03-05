Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F31032ED43
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Mar 2021 15:37:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9F22C100EBBBE;
	Fri,  5 Mar 2021 06:37:52 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F0302100EBBBD
	for <linux-nvdimm@lists.01.org>; Fri,  5 Mar 2021 06:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1614955068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=56Lhi7IGAbk10zBLaXtZqqEqwjnTSWPuQuSN6YXXg00=;
	b=hHaLg39+70XYp/ZIStU7dIwKiAw+YXo3k5Oiel1nSOpNc4pRW4OfAXk81DUs2P90KPbf4q
	soO/UYxnWAjE1Ovwzf6gazX/O/EhCuCB0p/92GLPdgnGs473KM+Xc5UtpRZjotP4pBN1CM
	kfjDRSVHO/1mB3RzQRThxGws+9H8+0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-kjDRpmISPXKIaZR1Y6q9mQ-1; Fri, 05 Mar 2021 09:37:44 -0500
X-MC-Unique: kjDRpmISPXKIaZR1Y6q9mQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4049876E07;
	Fri,  5 Mar 2021 14:37:42 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C294D5D9C0;
	Fri,  5 Mar 2021 14:37:38 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [block]  52f019d43c: ndctl.test-libndctl.fail
References: <20210305055900.GC31481@xsang-OptiPlex-9020>
	<20210305074204.GA17414@lst.de>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Fri, 05 Mar 2021 09:38:19 -0500
In-Reply-To: <20210305074204.GA17414@lst.de> (Christoph Hellwig's message of
	"Fri, 5 Mar 2021 08:42:04 +0100")
Message-ID: <x49y2f1aco4.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Message-ID-Hash: JBZILUW4HUM5BPTUWPD4HT7HONQ5FVFA
X-Message-ID-Hash: JBZILUW4HUM5BPTUWPD4HT7HONQ5FVFA
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: kernel test robot <oliver.sang@intel.com>, Jens Axboe <axboe@kernel.dk>, Oleksii Kurochko <olkuroch@cisco.com>, Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>, LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org, lkp@intel.com, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JBZILUW4HUM5BPTUWPD4HT7HONQ5FVFA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Christoph Hellwig <hch@lst.de> writes:

> Dan,
>
> can you make any sense of thos report?
>
> name='nfit_test'
> path='/lib/modules/5.11.0-rc5-00003-g52f019d43c22/extra/test/nfit_test.ko'
>> check_set_config_data: dimm: 0 read2 data miscompare: 0
>> check_set_config_data: dimm: 0x1 read2 data miscompare: 0
>> check_set_config_data: dimm: 0x100 read2 data miscompare: 0
>> check_set_config_data: dimm: 0x101 read2 data miscompare: 0
>> check_dax_autodetect: dax_ndns: 0x558a74d92f00 ndns: 0x558a74d92f00
>> check_dax_autodetect: dax_ndns: 0x558a74d91f40 ndns: 0x558a74d91f40
>> check_pfn_autodetect: pfn_ndns: 0x558a74d91f40 ndns: 0x558a74d91f40
>> check_pfn_autodetect: pfn_ndns: 0x558a74d8c5e0 ndns: 0x558a74d8c5e0
>> check_btt_autodetect: btt_ndns: 0x558a74d8c5e0 ndns: 0x558a74d8c5e0
>> check_btt_autodetect: btt_ndns: 0x558a74da1390 ndns: 0x558a74da1390
>> check_btt_autodetect: btt_ndns: 0x558a74d8c5e0 ndns: 0x558a74d8c5e0
>> check_btt_autodetect: btt_ndns: 0x558a74d91f40 ndns: 0x558a74d91f40
>> namespace7.0: failed to write /dev/pmem7
>> check_namespaces: namespace7.0 validate_bdev failed
>> ndctl-test1 failed: -6

This is from test/libndctl.c in the ndctl repo:

        fd = open(bdevpath, O_RDONLY);
        if (fd < 0) {
                fprintf(stderr, "%s: failed to open(%s, O_RDONLY)\n",
                                devname, bdevpath);
                return -ENXIO;
        }
...
        ro = 0;
        rc = ioctl(fd, BLKROSET, &ro);
        if (rc < 0) {
                fprintf(stderr, "%s: BLKROSET failed\n",
                                devname);
                rc = -errno;
                goto out;
        }

        close(fd);
        fd = open(bdevpath, O_RDWR|O_DIRECT);
...
        if (write(fd, buf, 4096) < 4096) {
                fprintf(stderr, "%s: failed to write %s\n",
                                devname, bdevpath);
                rc = -ENXIO;
                goto out;
        }

HTH,
Jeff
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
