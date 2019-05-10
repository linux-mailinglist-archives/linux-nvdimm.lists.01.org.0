Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 839391A3D9
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 May 2019 22:15:44 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8D08C2126CF9C;
	Fri, 10 May 2019 13:15:42 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5C8E12121493E
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 13:15:41 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g18so6470544otj.11
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 13:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=haQb/JJEXbzGwY8djXGgfBZiIn+/x5Yv5AUgQ4m38OM=;
 b=WEeqre45hj7sSv58I/e7A5coRY+GxRJHinyFbk3h7U4aJrBJYpdYkhq9T1r4+5or5d
 jRR3GR4Z+c950AiPGFzXe4QQXlx4J3RcgRXk7RadE4sRSsQK7+mC+RHs2IEhRwKUI7Zy
 /T1NcmREZZ/qpW4sfz6npTMRE2tie3uif+puXikMYRBthExnMytzYTF00hoiHxBr5/P0
 7jNqauenyRbY3EQ6raNfL+QovOy++Rd9rquniNrMmi7pGZFEPwXRnlT7u+kZ42rUMzcD
 v4eAUwbD5Njo6W9aRbjgU1OhGsIT/fgW+T3LVLT6M51FFHqJTii+xqDcL8xDANdQWGtc
 2Dxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=haQb/JJEXbzGwY8djXGgfBZiIn+/x5Yv5AUgQ4m38OM=;
 b=iF0NibEDclVoJra+7irfz7BdJJesBFtJmZw2RLahI/ldPkl/HjGAj8EXBYmPLL8mgH
 Z44Nl8Lemsi7xqaEEZAZpWDYVgM2W8UhWcX4+HpJ7tNjogQ2hfQYeZvNI2kt0PMwr7ZZ
 nSdMoAKqFCEel8GK8YKcdNAdutow/EfumDAP95Lw1FQj5TQ7v/pbd3JC1EIxcsAjxjk5
 gh8m2u+1v/rdu7m6YO96QNkzRdpTJXo/xf7yuyHvFJMHOLXou0TsgoBCgWW1RHo3oOhK
 NEqw6k2wElgqsU9SWnhsEkkhb9E7yILDdhTwHREnpgcU6btevwcs/KNE+Y/HXRp7GDlt
 d9ug==
X-Gm-Message-State: APjAAAVh8P82BdCl1HzCj1Gx0fICIwjGWgQT1ePQaGxrswJdDrW4WIAG
 jPjpzHaDkOFX/T4w2M/sn56BSTz1qc3m/PUIzP/ufA==
X-Google-Smtp-Source: APXvYqzGzV4vCYOWqp7L7v2b9h2jjvTQectDwMiq79aWZo81gT17ipgMl7EwlMGGL3BIVEygxWA2BmYfTI9FLFAVAXk=
X-Received: by 2002:a9d:6f19:: with SMTP id n25mr2918893otq.367.1557519340452; 
 Fri, 10 May 2019 13:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190510155202.14737-1-pagupta@redhat.com>
In-Reply-To: <20190510155202.14737-1-pagupta@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 10 May 2019 13:15:29 -0700
Message-ID: <CAPcyv4joEZaePvzc__N9Q3nozoHgQn7hNFPjBVo5BP6cc4rkEA@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] virtio pmem driver
To: Pankaj Gupta <pagupta@redhat.com>
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
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 david <david@fromorbit.com>, Qemu Developers <qemu-devel@nongnu.org>,
 virtualization@lists.linux-foundation.org,
 Andreas Dilger <adilger.kernel@dilger.ca>, Ross Zwisler <zwisler@kernel.org>,
 Andrea Arcangeli <aarcange@redhat.com>, jstaron@google.com,
 linux-nvdimm <linux-nvdimm@lists.01.org>, David Hildenbrand <david@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
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

On Fri, May 10, 2019 at 8:52 AM Pankaj Gupta <pagupta@redhat.com> wrote:
>
>  Hi Michael & Dan,
>
>  Please review/ack the patch series from LIBNVDIMM & VIRTIO side.
>  We have ack on ext4, xfs patches(4, 5 & 6) patch 2. Still need
>  your ack on nvdimm patches(1 & 3) & virtio patch 2.

I was planning to merge these via the nvdimm tree, not ack them. Did
you have another maintainer lined up to take these patches?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
