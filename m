Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A6012506
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 May 2019 01:21:19 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0F606212449EB;
	Thu,  2 May 2019 16:21:18 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A51EE21205162
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 16:21:16 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id f23so3715458otl.9
 for <linux-nvdimm@lists.01.org>; Thu, 02 May 2019 16:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0i5+J/OZLL+JOOwALn6I5uwFawiDlG+N57qbnmaBmtk=;
 b=sWawHLNMKR0Z8Wcp0xOaPFpIrQ6QpmbbM6zigcIzNj1WJvbeh+Sjw9n6tIJoHgDaA6
 GgHltRLQSt1agn1TOVUOGI46HUvE24ww/7wBYRHYRdNKiWzKHHbf5etMXZ20pnRvnGIT
 QxTurydSSdEyMyi2Qabh03VR59K4+NgTK148H0EFCAUUYSf8o8pEDxzDGjdTWBY4TUca
 UWHAuYyxKgs+/C5mYh4EOm/HxHdIMEG82VoybqBmlv5jAXSswdNp6xkxYFfh4c5dXIip
 rrOFS4TWce+QrFAoelxpv3OXDps3RdQeyQdRCaSHgv7pxXJ8hfmeq4/ufkrHiwBWMeqm
 VKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0i5+J/OZLL+JOOwALn6I5uwFawiDlG+N57qbnmaBmtk=;
 b=YTrZTByTTrbBudV53ElrY5/Tfar9qY1czp3QM58HnXtblVqikrSnTnO8MXFgkO9heF
 t+C730CANUkS9KhCy6l/RDenqGPue1MGMTcCzF/ArEUrHHMAZjJXAQroosuw5eocANui
 UFN6lsd485+BI1BYHHsRk/FDvEf9sVu/AdwGqSmTn6oMbciZYoiiTmybaZxuROzSsUC1
 f4LCH+K6VBkpI3mo5NsLqYLeeywEow4kNAzMEvhziKx02ENyeMGZX9NENKf73PAyQRtd
 3iKIU9Wr0eA7Pv4aXMcaUrx2ri9B8dM3PeyQuCbxXdBZ9+jph4aESdgaHFpChVYjPLlQ
 pJ7w==
X-Gm-Message-State: APjAAAWem8Esrmn9hVj+WLCbDnKSKeeWPpomsD/jJf/6IYJNa7JNknHr
 kUVmwDpDDFZpeo4wfhNcv6rXmSil9V02vtGSl17PAQ==
X-Google-Smtp-Source: APXvYqw0TgWpuTZRL+SCcmgsjTeKduMjL6fHbHh+v1JzAjaquiFt8e1uuHJEKU0m3H+lLNeHniLWZoNoGl8pEH0sriQ=
X-Received: by 2002:a9d:222c:: with SMTP id o41mr4495514ota.353.1556839275827; 
 Thu, 02 May 2019 16:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+CK2bBT=goxf5KWLhca7uQutUj9670aL9r02_+BsJ+bLkjj=g@mail.gmail.com>
 <CAPcyv4gWZxSepaACiyR43qytA1jR8fVaeLy1rv7dFJW-ZE63EA@mail.gmail.com>
In-Reply-To: <CAPcyv4gWZxSepaACiyR43qytA1jR8fVaeLy1rv7dFJW-ZE63EA@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 2 May 2019 16:21:05 -0700
Message-ID: <CAPcyv4j1221GA6xQww741v-RdZame5D0q60qcxO5u=tv9MDoRw@mail.gmail.com>
Subject: Re: [PATCH v6 00/12] mm: Sub-section memory hotplug support
To: Pavel Tatashin <pasha.tatashin@soleen.com>
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
Cc: Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 stable <stable@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, May 2, 2019 at 4:20 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Thu, May 2, 2019 at 3:46 PM Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
> >
> > Hi Dan,
> >
> > How do you test these patches? Do you have any instructions?
>
> Yes, I briefly mentioned this in the cover letter, but here is the
> test I am using:

Sorry, fumble fingered the 'send' button, here is that link:

https://github.com/pmem/ndctl/blob/subsection-pending/test/sub-section.sh
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
