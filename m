Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BAB61589
	for <lists+linux-nvdimm@lfdr.de>; Sun,  7 Jul 2019 18:35:05 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 71AAE212ABA3F;
	Sun,  7 Jul 2019 09:35:02 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=18.9.28.11; helo=outgoing.mit.edu; envelope-from=tytso@mit.edu;
 receiver=linux-nvdimm@lists.01.org 
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0EF81212A36D6
 for <linux-nvdimm@lists.01.org>; Sun,  7 Jul 2019 09:35:00 -0700 (PDT)
Received: from callcc.thunk.org (75-104-86-74.mobility.exede.net
 [75.104.86.74] (may be forged)) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x67GYGms007613
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 7 Jul 2019 12:34:23 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
 id 26D6A42002E; Sun,  7 Jul 2019 12:34:15 -0400 (EDT)
Date: Sun, 7 Jul 2019 12:34:15 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Pankaj Gupta <pagupta@redhat.com>
Subject: Re: [PATCH v15 6/7] ext4: disable map_sync for async flush
Message-ID: <20190707163415.GA19775@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
 Pankaj Gupta <pagupta@redhat.com>, dm-devel@redhat.com,
 linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org,
 qemu-devel@nongnu.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, dan.j.williams@intel.com,
 zwisler@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
 mst@redhat.com, jasowang@redhat.com, willy@infradead.org,
 rjw@rjwysocki.net, hch@infradead.org, lenb@kernel.org, jack@suse.cz,
 adilger.kernel@dilger.ca, darrick.wong@oracle.com,
 lcapitulino@redhat.com, kwolf@redhat.com, imammedo@redhat.com,
 jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com,
 stefanha@redhat.com, aarcange@redhat.com, david@redhat.com,
 david@fromorbit.com, cohuck@redhat.com,
 xiaoguangrong.eric@gmail.com, pbonzini@redhat.com,
 yuval.shaia@oracle.com, kilobyte@angband.pl, jstaron@google.com,
 rdunlap@infradead.org, snitzer@redhat.com
References: <20190705140328.20190-1-pagupta@redhat.com>
 <20190705140328.20190-7-pagupta@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190705140328.20190-7-pagupta@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: cohuck@redhat.com, jack@suse.cz, kvm@vger.kernel.org, mst@redhat.com,
 jasowang@redhat.com, david@fromorbit.com, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org, dm-devel@redhat.com,
 adilger.kernel@dilger.ca, zwisler@kernel.org, aarcange@redhat.com,
 jstaron@google.com, linux-nvdimm@lists.01.org, david@redhat.com,
 willy@infradead.org, hch@infradead.org, linux-acpi@vger.kernel.org,
 linux-ext4@vger.kernel.org, lenb@kernel.org, kilobyte@angband.pl,
 rdunlap@infradead.org, riel@surriel.com, yuval.shaia@oracle.com,
 stefanha@redhat.com, pbonzini@redhat.com, lcapitulino@redhat.com,
 kwolf@redhat.com, nilal@redhat.com, xiaoguangrong.eric@gmail.com,
 snitzer@redhat.com, darrick.wong@oracle.com, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, imammedo@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jul 05, 2019 at 07:33:27PM +0530, Pankaj Gupta wrote:
> Dont support 'MAP_SYNC' with non-DAX files and DAX files
> with asynchronous dax_device. Virtio pmem provides
> asynchronous host page cache flush mechanism. We don't
> support 'MAP_SYNC' with virtio pmem and ext4.
> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Acked-by: Theodore Ts'o <tytso@mit.edu>

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
