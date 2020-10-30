Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3556E2A08B3
	for <lists+linux-nvdimm@lfdr.de>; Fri, 30 Oct 2020 15:59:41 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 233E9164F3DBC;
	Fri, 30 Oct 2020 07:59:39 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com; envelope-from=k.griest04@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DA6BF164F3DB9
	for <linux-nvdimm@lists.01.org>; Fri, 30 Oct 2020 07:59:36 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id x1so7004014eds.1
        for <linux-nvdimm@lists.01.org>; Fri, 30 Oct 2020 07:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=9fkQXWnoPSypfyxvIrXWSyd1r4Ua0eeDJczOBpIf/BU=;
        b=TjZDjTDUyG5IOPAjtKhDz6bJNm6DqwPh3GYjQnJOtk58Qe+VS+LrjG9D+UJTL89L5a
         hPszd6YttBU2gVDN4Hgd0nVvKmUsgBGa0RfR9y4dU1VG6wqrOSeXXlqa/jT4b2a91QjD
         sT+ma7QKBtdbME0ZKxl0kc6DEI2BSZsRxuMkNkQsvOWxO6URWAKkh65L3Tk879AJ4LqG
         Bj9eXYFDUcjXqha9S32esb82rsLCjf9rEdFYrDoZfWxC18Um3HNxqbzetSufrWkdrmWB
         Hgfuw2XlX0g8ZkLr3paRT5DvZbKL3ccSJq24BaLzNsiQWn1tArC4uUyPSHMQ3hVqPZo6
         Sb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=9fkQXWnoPSypfyxvIrXWSyd1r4Ua0eeDJczOBpIf/BU=;
        b=tTWdqW202cx0CAGCFaeekfAPT6s8jz3glDCgd0BcYdKZUoAMLcV6oIbEggtLDktkz1
         jeZuopIJ5p2IZK8wf0R0Q6miJfepw8QSFecO1PwMJuFTKdNnoNAAl2qD1dvrVCW3cyfS
         OqG0WmZ1WqRGAHn9w1GCPuK9FYv0Qvs3QlZwLQi9TvEb1hFY5MZfz2bYdn1WrWHEFPkr
         /aeHVLWACipafKeyFhaBYbqXhWE90/DuZ8Cdh8A7wsAEPPdp/wdJhJkN5DGl94PzwgkJ
         p7jbI6+/iQWNvmbmEOu5YUss82jgmRv1AR305cxbWS2b63mEuoliDqkvdmdK0vGxe0yH
         Qbfw==
X-Gm-Message-State: AOAM532hcdKfWO1Dl1j0pAj5wO7ju9xMiRHCgh81RYETao7cDcYEPujg
	XVUWgVAFAEp7Tr1fmwDV+kHeK2Reeav6art+DA==
X-Google-Smtp-Source: ABdhPJz0XXuJnPS5g3+lbBiW+XXmkDUqYoNBDu76t3os6QvlPQSI6Onyl30CWs+Md1o+E0r28qs03HXLpOQosKz8YWo=
X-Received: by 2002:a50:f307:: with SMTP id p7mr2761574edm.235.1604069974505;
 Fri, 30 Oct 2020 07:59:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:f14c:0:0:0:0:0 with HTTP; Fri, 30 Oct 2020 07:59:34
 -0700 (PDT)
From: Liliane Abel <k.griest04@gmail.com>
Date: Fri, 30 Oct 2020 15:59:34 +0100
Message-ID: <CABAZL7=b-NWks3DKb=fdDjnu_xt_-CcJCqf-F5s0yQCFVH73-A@mail.gmail.com>
Subject: 
To: undisclosed-recipients:;
Message-ID-Hash: 2YJGRW7YWODBAJQV3HQMKSDUU5ISVPKH
X-Message-ID-Hash: 2YJGRW7YWODBAJQV3HQMKSDUU5ISVPKH
X-MailFrom: k.griest04@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: li.anable85@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2YJGRW7YWODBAJQV3HQMKSDUU5ISVPKH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dearest

Greeting my dear, I am Liliane Abel by name, The only daughter of late
Mr.Benson Abel. My father is one of the top Politician in our country
and my mother is a farmers and cocoa merchant when they were both
alive. After the death of my mother, long ago, my father was
controlling their business until he was poisoned by his business
associates which he suffered and died.

Before the death of my father, He told me about (two million five
hundred thousand united states dollars) which he deposited in the bank
in Lome-Togo, It was the money he intended to transfer overseas for
investment before he was poisoned. He also instructed me that I should
seek for foreign partners in any country of my choice who will assist
me transfer this money in overseas account where the money will be
wisely invested.
I am seeking for your kind assistance in the following ways:  (1) to
provide a safe bank account into where the money will be transferred
for investment. (2) To serve as a guardian of this fund since I am a
girl of 19 years old. (3) To make arrangement for me to come over to
your country to further my education. This is my reason for writing to
you. Please if you are willing to assist me I will offer you 25% of
the total money. Reply if  you are interested
Best regards.
Liliane Abel.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
