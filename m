Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F531C2D34
	for <lists+linux-nvdimm@lfdr.de>; Sun,  3 May 2020 17:05:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6CE471007B53E;
	Sun,  3 May 2020 08:04:15 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::144; helo=mail-il1-x144.google.com; envelope-from=siregueye690@gmail.com; receiver=<UNKNOWN> 
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A90D3100E5D94
	for <linux-nvdimm@lists.01.org>; Sun,  3 May 2020 08:04:13 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id b18so8930533ilf.2
        for <linux-nvdimm@lists.01.org>; Sun, 03 May 2020 08:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=7pSTTOgZ+gT6KbdmMkmexbsXUVT//t5Stk1qx9sIS14=;
        b=C+R/sJXiPPPmZY95gi22LG/IsPeD+jvYXHZ0YJWXEOFqHkMuV1Rq2Z27CSgRmI1qQE
         Z1Y7ncFkE+LamaJRuIj9H8W5XPs/yKRiAkP00D/ziKknBiVeZffZAM5cVjDIfpcCqFWj
         ydAJUOhqNmPuTfwM2xLhANL2agwJNeoQCpBt27qU0PqYymjlG2Nk9Mhs3kK8T3Dnqj1k
         1b68tSyxlBucLE55K7KDqLwWBskuFiuolT0LEz41XyObOYX1mJn0QuOQjHQ0cX5QkKZ+
         0nBHrX2VCxKwvTiycCC/ydC2ZI+hgsgYQ6K8vubaeQIqzsEAWlfp7CMzIUgIZaz4Jl+R
         NQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7pSTTOgZ+gT6KbdmMkmexbsXUVT//t5Stk1qx9sIS14=;
        b=dHRgvbD91aZVK9tosC+MjzIK4xdguIUQDuipYLvGzKmx5jeBLdMi/yYe3cbQrkrxqT
         /BFAjEZZ54at1JXTtdCA0qA/QXaeGsSDIYZeMh/8basqWuYQE+OqI0cHFuqTGFl94qV+
         mToCBF8qj1crvPgCjOwGWM0zWiCIOgB0SQlbPCFjVcegFrgpL3air3hwx+QUVHDkywBS
         PwlmKMem45v/tmmTzsIQaru74o/eYzl3wMC4OJ8Jx1/4VZZUaGU94lHng5+pKwsRa9hx
         RPI51ZoFP+NwI1VF4OrNj7Ts9zBlQbulAK6Lr0sp+badgJNg+rorSff9oLqNhlL0ySX0
         ZGxw==
X-Gm-Message-State: AGi0PuaOKQ2lI/GzbJ//nXFPP/pWQBPVzEx4TAPXl7HJtpbskHNgTx3R
	0Q0XvNv/Pe5NHqNyAQoRrmp3AqFMZieSJB8R6PE=
X-Google-Smtp-Source: APiQypJbPESYwPkOv3/fDQEqzbxPntfsIELvI0aI/02lUgeHLIFKGW5yyDdw/wPdLl/tJ8jUts4oRZ7RhPJuqfi/A0s=
X-Received: by 2002:a92:9c0a:: with SMTP id h10mr11059481ili.12.1588518342957;
 Sun, 03 May 2020 08:05:42 -0700 (PDT)
MIME-Version: 1.0
From: Amelia Ibrahim <ameliaibrahim520@gmail.com>
Date: Sun, 3 May 2020 16:05:32 +0100
Message-ID: <CAGtvjUi4wLCFz4W5PjXsw7qPfck8jZpHSk1iyDG8d1AKYSX+eg@mail.gmail.com>
Subject: Hello
To: undisclosed-recipients:;
Message-ID-Hash: DKC4LC4DMUTYHG2JHEVMQD57ICUJQ4CH
X-Message-ID-Hash: DKC4LC4DMUTYHG2JHEVMQD57ICUJQ4CH
X-MailFrom: siregueye690@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DKC4LC4DMUTYHG2JHEVMQD57ICUJQ4CH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

    Hello, I will like to talk with you
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
