Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4423D1AD29
	for <lists+linux-nvdimm@lfdr.de>; Sun, 12 May 2019 18:52:41 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 01D8E21268F9B;
	Sun, 12 May 2019 09:52:40 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.85.222.193; helo=mail-qk1-f193.google.com;
 envelope-from=mst@redhat.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 32C7021260A5F
 for <linux-nvdimm@lists.01.org>; Sun, 12 May 2019 09:52:38 -0700 (PDT)
Received: by mail-qk1-f193.google.com with SMTP id k189so6679974qkc.0
 for <linux-nvdimm@lists.01.org>; Sun, 12 May 2019 09:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tv7+SbtJTW406Xn58+T3o8cNYwcZMfaM6OpdKpHHAGI=;
 b=DeAUUzbmpMJ68DZYOE27r0zR+smbrAwsUyLVuLFWrePYLTWD6cc6OFXH6KpTAonxRn
 CeVYJfgfNou2uUGo4rcuso4EmLXy/ChnT9SItkhQRLry04SCT3sAfcscUR1DP6NqkJnN
 kCSlN54QQY0tu0vX6BRcAFa+TKkM5BHWMqi66Onjpne5nqKL/7Sp36i01Bo0l69pA3r2
 W/NKsdXbDnGlvtBcA7l3eQTSMwUrPaQy8eEQv3EdpfkPSh3BhCmxrun0z5MJNbFoNzfP
 GVAagImQbFOsIFfkEiXGVTXXQvxxpV32nxEDpNo9ISMQsnOGWOK/e4JAWAF5W9fwqqrz
 k9Yw==
X-Gm-Message-State: APjAAAXcnidy3e1tIuc3CFZzWQx92wJWnJuMVq4ca672dlWT9tXlvHTh
 vp78E3WusvdhZPiXlRUw++rNLA==
X-Google-Smtp-Source: APXvYqxk9SXE+foxB/6DAoFm93oskr+MiF5xkYgB0SEkfaz8myE/mnL8/ZXigyA4Y2k8vy6g71yM+Q==
X-Received: by 2002:a37:9fcb:: with SMTP id
 i194mr18869154qke.258.1557679957115; 
 Sun, 12 May 2019 09:52:37 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
 [173.76.105.71])
 by smtp.gmail.com with ESMTPSA id o37sm4708706qta.86.2019.05.12.09.52.34
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 12 May 2019 09:52:36 -0700 (PDT)
Date: Sun, 12 May 2019 12:52:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Pankaj Gupta <pagupta@redhat.com>
Subject: Re: [PATCH v8 0/6] virtio pmem driver
Message-ID: <20190512125221-mutt-send-email-mst@kernel.org>
References: <20190510155202.14737-1-pagupta@redhat.com>
 <CAPcyv4joEZaePvzc__N9Q3nozoHgQn7hNFPjBVo5BP6cc4rkEA@mail.gmail.com>
 <1909759746.28039539.1557531183427.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1909759746.28039539.1557531183427.JavaMail.zimbra@redhat.com>
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
Cc: cohuck@redhat.com, Jan Kara <jack@suse.cz>, KVM list <kvm@vger.kernel.org>,
 David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>,
 david <david@fromorbit.com>, Qemu Developers <qemu-devel@nongnu.org>,
 virtualization@lists.linux-foundation.org,
 Andreas Dilger <adilger.kernel@dilger.ca>, Ross Zwisler <zwisler@kernel.org>,
 Andrea Arcangeli <aarcange@redhat.com>, jstaron@google.com,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Len Brown <lenb@kernel.org>,
 Adam Borowski <kilobyte@angband.pl>, Rik van Riel <riel@surriel.com>,
 yuval shaia <yuval.shaia@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>,
 Theodore Ts'o <tytso@mit.edu>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Darrick J. Wong" <darrick.wong@oracle.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-xfs <linux-xfs@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, May 10, 2019 at 07:33:03PM -0400, Pankaj Gupta wrote:
> 
> > >
> > >  Hi Michael & Dan,
> > >
> > >  Please review/ack the patch series from LIBNVDIMM & VIRTIO side.
> > >  We have ack on ext4, xfs patches(4, 5 & 6) patch 2. Still need
> > >  your ack on nvdimm patches(1 & 3) & virtio patch 2.
> > 
> > I was planning to merge these via the nvdimm tree, not ack them. Did
> > you have another maintainer lined up to take these patches?
> 
> Sorry! for not being clear on this. I wanted to say same.
> 
> Proposed the patch series to be merged via nvdimm tree as kindly agreed
> by you. We only need an ack on virtio patch 2 from Micahel.
> 
> Thank you for all your help.
> 
> Best regards,
> Pankaj Gupta

Fine by me.

> > 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
