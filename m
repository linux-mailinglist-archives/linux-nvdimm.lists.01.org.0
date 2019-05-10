Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E961A2DE
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 May 2019 20:14:22 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6DC4C2126CF8B;
	Fri, 10 May 2019 11:14:20 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 44A7621268F91
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 11:14:19 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id r7so1925038otn.6
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 11:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5U30ojrLveO0inIWQQWVEjYKxtRzBkXH88X7bSSzUP8=;
 b=2PD8SaZYjCX5fOspaHLvF+HDNUNfPqOCRXbzBxnlOalcbNSl2AINgSRjHpgf3gU3KY
 Eja3ACdueZfJ9yGmcuCvicELvwx5ByLlYQZuLrKoBdoFf5EWkK5YmRD54TQ2yeglijrs
 U0TTqevIjlZ+fr4h7nBfaBnmlqQ4NdMPc8Qzq73250yzHbW4jSm8kWXZtOrm+d1Wb1Iv
 YaIVtuwhdFPe8UJo0U2VVwLSfpLJD891ErFam1bAQGIXEbu/JkTToR1dLeXCQpfIOMHQ
 zsRCKc2uPrnGdINNn99KF1I7evMFXELfA3gd6MZlkmyfVE+tlUaGD8ZJJADiJp3dyvtt
 TGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5U30ojrLveO0inIWQQWVEjYKxtRzBkXH88X7bSSzUP8=;
 b=jCIgFkwM+Ic+VDIua5I3D1VGipdoZVvB+zKs1dYZnIAnOQt5IIeN5rO317yPv02F1z
 4cw8bkXkhrrGwnRO4bTPKYd5D3TzsDUu8Sqt8oWBB3fBSr7cWoLTt471+fLPVIPQI46Z
 XaGgJAMBH01duNeqA5yzJUt/i9+VUBfdEzFPYpJOIDMIjf+aPYUrhDdZ75DSCYn3kIRy
 480BWauQvhz0tgXYMHZs2AEVYXnUOZU+bY+BhgQmpoYrTGVrwUYYG84p8wofIl0gufSj
 7To+THGeHuGLeeXldlqajMikh5v8fU90DfU1IUrckuOMJIMuPL02pYgyJcBjc5luL9R8
 TxMw==
X-Gm-Message-State: APjAAAWSNCaep458gcA4NKZMvWuedtYPfS26B0414kq7L+W4GQBKyozb
 5K7JILdPjVUQIRpjLasFeYA6i6Zz2jbZmNK3NLEJWrOoumw=
X-Google-Smtp-Source: APXvYqzCkRU/LApt95XEDdDEUgIIw7lC4YzebWLylbbCwywX0NVlDoO/rBv9jia1H70b/HmzgSWapfax4U0jRSj8Wlc=
X-Received: by 2002:a9d:6f19:: with SMTP id n25mr2528783otq.367.1557512058405; 
 Fri, 10 May 2019 11:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <1557417933-15701-1-git-send-email-larry.bassel@oracle.com>
 <1557417933-15701-2-git-send-email-larry.bassel@oracle.com>
 <AT5PR8401MB116928031D52A318F04A2819AB0C0@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <AT5PR8401MB116928031D52A318F04A2819AB0C0@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 10 May 2019 11:14:07 -0700
Message-ID: <CAPcyv4juGEo=sMX01YuqPY9oYDjBjmRp7GvreNnX8YvKQz=SjA@mail.gmail.com>
Subject: Re: [PATCH, RFC 1/2] Add config option to enable FS/DAX PMD sharing
To: "Elliott, Robert (Servers)" <elliott@hpe.com>
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
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "willy@infradead.org" <willy@infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, May 10, 2019 at 9:32 AM Elliott, Robert (Servers)
<elliott@hpe.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Linux-nvdimm <linux-nvdimm-bounces@lists.01.org> On Behalf Of
> > Larry Bassel
> > Sent: Thursday, May 09, 2019 11:06 AM
> > Subject: [PATCH, RFC 1/2] Add config option to enable FS/DAX PMD
> > sharing
> >
> > If enabled, sharing of FS/DAX PMDs will be attempted.
> >
> ...
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> ...
> >
> > +config MAY_SHARE_FSDAX_PMD
> > +def_bool y
> > +
>
> Is a config option really necessary - is there any reason to
> not choose to do this?

Agree. Either the arch implementation supports it or it doesn't, I
don't see a need for any further configuration flexibility. Seems
ARCH_WANT_HUGE_PMD_SHARE should be renamed ARCH_HAS_HUGE_PMD_SHARE and
then auto-enable it.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
