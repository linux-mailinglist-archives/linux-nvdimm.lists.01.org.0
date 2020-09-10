Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42CE26432F
	for <lists+linux-nvdimm@lfdr.de>; Thu, 10 Sep 2020 12:04:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 29ED5139F161B;
	Thu, 10 Sep 2020 03:04:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::d42; helo=mail-io1-xd42.google.com; envelope-from=pankaj.gupta.linux@gmail.com; receiver=<UNKNOWN> 
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5C82D136D4F34
	for <linux-nvdimm@lists.01.org>; Thu, 10 Sep 2020 03:03:57 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g128so6376389iof.11
        for <linux-nvdimm@lists.01.org>; Thu, 10 Sep 2020 03:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y2JcHZ6MFjyHAlvpoNmjBZx8lY6aHDHdPBn5/fOR/C0=;
        b=SHjrnz+amdW+kH6msAJS1SjMD4qKf//Oke1bSThNY6pdCjvbQ+x27OU9YlV9B+SYEj
         x4WGit+P6lzFULpqfB7FM8A7DBakbna0aDoBRBFhMpId+FTvnxVfdSZkL+7UBKf6R7Li
         Qcwq03DQg64ECu81QBftLC7POFMrjdMmsyy3+USM1cM0a37HSojGGcOCLkCDzAtOUwGK
         CIURbhZ42k7j/+YCP7SNIquHjrH+i0bOrZQqdbBLNZOfz6En+Jn7mMcXdMSqXCC+jQZD
         lYjq+VOUPTp8EL0T/MjzHs07HO7C27K2v1VXkWq9+vJ2IE9wwkcgALGw9zQQ/fsUdMbG
         yKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y2JcHZ6MFjyHAlvpoNmjBZx8lY6aHDHdPBn5/fOR/C0=;
        b=gAB68Ak/b25B+bl9M26aIdZD2kC7ld7Ha1ZEvc6bdLzY1VC6ld8S6WBJw2J+SS0Jym
         nKhm6PqWNdryyCav4qBMpY1nvkg048bIV1tIlAwbl+uoK5x51QVW7D7H4a8L8rtxxce4
         NLK85UcndY3BWPkh0UkqigtRG7ule+u18zXBuzjzpaw4O9z7/NeQmrKFR3F7bpojyVxz
         nZyL2i12yziY4/LaszSDwiIk0BEyW9zCLxDPSErV6le4TXFVAbrf1SP26s2OeoNsJ1Jv
         u0g0JN7Z8Bur81XuiK8LjheITfQ8oCNx2WCg8DjHJ/H9H7+XXJK+ll+L33ardWOPR/B/
         4krQ==
X-Gm-Message-State: AOAM533WGxRqS8M5WNp0iTkRBud767Xj5ZDWjKhZ4kuzXOHy0k01g4pe
	fnlRqwZ41/SSwbrTyvk78JPwO3hycTjRkaTdITo=
X-Google-Smtp-Source: ABdhPJyLZcGsxd4Zx+mCdXy45ufEwo0KPMGwBXhtsOyHb64xVG7npyu9cbgFOz4UWOemWTgujXWUOhR54K4+16Md/2Y=
X-Received: by 2002:a5d:8b4c:: with SMTP id c12mr6859868iot.167.1599732236621;
 Thu, 10 Sep 2020 03:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200910091340.8654-1-david@redhat.com> <20200910091340.8654-5-david@redhat.com>
In-Reply-To: <20200910091340.8654-5-david@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Thu, 10 Sep 2020 12:03:45 +0200
Message-ID: <CAM9Jb+j=8-Fpyg2fizM_3FenF649y2AKA8rsWaQzwCgX8Da7+g@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] mm/memory_hotplug: MEMHP_MERGE_RESOURCE to specify
 merging of System RAM resources
To: David Hildenbrand <david@redhat.com>
Message-ID-Hash: 6HGRIVD7UGLIFWSAJCH2HV2IGZODPVC3
X-Message-ID-Hash: 6HGRIVD7UGLIFWSAJCH2HV2IGZODPVC3
X-MailFrom: pankaj.gupta.linux@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Linux MM <linux-mm@kvack.org>, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, Julien Grall <julien@xen.org>, Baoquan He <bhe@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6HGRIVD7UGLIFWSAJCH2HV2IGZODPVC3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Looks good to me.

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
